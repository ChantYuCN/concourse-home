# Informer 

Informer use ClientSet to interact with APIserver.  
Informer is a eternality goroutine.  
**Each K8s resource has own informer**.  (include informer and lister method.)  
example: func NewNamespaceController()


## example

```go
...
import (
  "k8s.io/client-go/tools/cache"
)


clientset, err := kubernetes.NewForConfig(config)
stopCh := make(chan struct{})
defer close(stopch)
sharedInformers := informers.NewSharedInformerFactory(clientset, time.Minute)
informer := sharedInformer.Core().V1().Pods().Informer()
informer.AddEventHandler(cache.ResourceEventHandlerFuncs{
  AddFunc: func(obj interface{} {
    // ...
  },
  UpdateFunc: func(obj interface{} {
    // ...
  },
  DeleteFunc  : func(obj interface{} {
    // ...
  })
  informer.Run(stopCh)
}) 

```
