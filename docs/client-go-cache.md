# k8s.io/client-go/tools/cache  

Package cache is a client-side caching mechanism.
Reduce request counts.  
Reflector watches a server and updates a Stores. (simply caches objects, FIFO queue) 

### example  

```go
// source simulates an apiserver object endpoint.
source := fcache.NewFakeControllerSource()

// This will hold the downstream state, as we know it.
downstream := NewStore(DeletionHandlingMetaNamespaceKeyFunc)

// This will hold incoming changes. Note how we pass downstream in as a
// KeyLister, that way resync operations will result in the correct set
// of update/delete deltas.
fifo := NewDeltaFIFOWithOptions(DeltaFIFOOptions{
	KeyFunction:  MetaNamespaceKeyFunc,
	KnownObjects: downstream,
})

// Let's do threadsafe output to get predictable test results.
deletionCounter := make(chan string, 1000)

cfg := &Config{
	Queue:            fifo,
	ListerWatcher:    source,
	ObjectType:       &v1.Pod{},
	FullResyncPeriod: time.Millisecond * 100,
	RetryOnError:     false,

	// Let's implement a simple controller that just deletes
	// everything that comes in.
	Process: func(obj interface{}, isInInitialList bool) error {
		// Obj is from the Pop method of the Queue we make above.
		newest := obj.(Deltas).Newest()

		if newest.Type != Deleted {
			// Update our downstream store.
			err := downstream.Add(newest.Object)
			if err != nil {
				return err
			}

			// Delete this object.
			source.Delete(newest.Object.(runtime.Object))
		} else {
			// Update our downstream store.
			err := downstream.Delete(newest.Object)
			if err != nil {
				return err
			}

			// fifo's KeyOf is easiest, because it handles
			// DeletedFinalStateUnknown markers.
			key, err := fifo.KeyOf(newest.Object)
			if err != nil {
				return err
			}

			// Report this deletion.
			deletionCounter <- key
		}
		return nil
	},
}

// Create the controller and run it until we close stop.
stop := make(chan struct{})
defer close(stop)
go New(cfg).Run(stop)

// Let's add a few objects to the source.
testIDs := []string{"a-hello", "b-controller", "c-framework"}
for _, name := range testIDs {
	// Note that these pods are not valid-- the fake source doesn't
	// call validation or anything.
	source.Add(&v1.Pod{ObjectMeta: metav1.ObjectMeta{Name: name}})
}

// Let's wait for the controller to process the things we just added.
outputSet := sets.String{}
for i := 0; i < len(testIDs); i++ {
	outputSet.Insert(<-deletionCounter)
}

for _, key := range outputSet.List() {
	fmt.Println(key)
}

```


## Reflector

Reflector watches a specified resource and causes all changes to be reflected in the given store.  
Controller is a low-level controller that is parameterized by a Config and used in sharedIndexInformer.  
Controller interface  

- Run(run a Reflector, repeatedly Pop from the Queue)
- HasSynced
- LastSyncResourceVersion

