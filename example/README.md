# Pipeline

## Schema

### jobs

Required  

- name
- plan

the steps in plan

- get: get resource (ex: git or time)
- task: Execute a task

### resources

Optional  

### resource types

Optional  

### var sources

Optional  

### groups

Optional  

### display

Optional  

## Manage pipeline

Create pipeline on targetName main team 

```console
fly -t targetName set-pipeline -c example/helloworld.yaml -p hellowordpipeline
jobs:
  job job has been added:
+ name: job
+ plan:
+ - config:
+     image_resource:
+       name: ""
+       source:
+         repository: busybox
+       type: registry-image
+     platform: linux
+     run:
+       args:
+       - Hello world!
+       path: echo
+   task: simple-task
+ public: true
+ serial: true

pipeline name: hellowordpipeline

apply configuration? [yN]: y
pipeline created!
you can view your pipeline here: http://[host ip]:8080/teams/main/pipelines/hellowordpipeline

the pipeline is currently paused. to unpause, either:
  - run the unpause-pipeline command:
    fly -t targetName unpause-pipeline -p hellowordpipeline
  - click play next to the pipeline in the web ui

```

List pipeline on targetName main team  

```console
fly -t targetName pipelines
id  name               paused  public  last updated
1   hellowordpipeline  yes     no      2024-03-15 03:27:47 +0000 UTC
```

Make the pipeline be public. It can be viewed by other teams  

```console
fly -t targetName expose-pipeline --pipeline hellowordpipeline
```


Schedule/unlock job and resource checking

```console
fly -t targetName unpause-pipeline --pipeline hellowordpipeline
unpaused 'hellowordpipeline'
fly -t targetName  unpause-job  -j hellowordpipeline/job
unpaused 'job'
```

List the jobs in the pipeline  

```console
fly -t targetName  jobs -p hellowordpipeline
name  paused  status     next
job   no      succeeded  n/a
```

Trigger a job

```console
fly -t targetName trigger-job -j hellowordpipeline/job
started hellowordpipeline/job #3
fly -t targetName  builds -p hellowordpipeline
id  name                     status     start                     end                       duration  team  created by
3   hellowordpipeline/job/3  succeeded  2024-03-15@05:31:01+0000  2024-03-15@05:31:08+0000  7s        main  test
2   hellowordpipeline/job/2  succeeded  2024-03-15@03:47:37+0000  2024-03-15@03:48:05+0000  28s       main  test
1   hellowordpipeline/job/1  aborted    n/a                       2024-03-15@03:42:57+0000  n/a       main  test
fly -t targetName  rerun-build -j hellowordpipeline/job  -b 2
fly -t targetName  builds -p hellowordpipeline
id  name                       status     start                     end                       duration  team  created by
3   hellowordpipeline/job/3    succeeded  2024-03-15@05:31:01+0000  2024-03-15@05:31:08+0000  7s        main  test
4   hellowordpipeline/job/2.1  succeeded  2024-03-15@05:34:22+0000  2024-03-15@05:34:27+0000  5s        main  test
2   hellowordpipeline/job/2    succeeded  2024-03-15@03:47:37+0000  2024-03-15@03:48:05+0000  28s       main  test
1   hellowordpipeline/job/1    aborted    n/a                       2024-03-15@03:42:57+0000  n/a       main  test
```

After trigger job  

```console
checking pipeline is not paused
checking job is not paused
waiting for a suitable set of input versions
checking max-in-flight is not reached
task: simple-task
selected worker: 8b63640bc164
Hello Chant!
```




reference  
https://github.com/concourse/examples  
