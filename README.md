# CI

concourse + gitea  

Run install-ci.sh for simple env.  
Concourse run both 'web' and 'worker' together, auto-wired.  


  generate-key   Generate RSA key for use with Concourse components.  
  land-worker    Safely drain a worker's assignments for temporary downtime.  
  migrate        Run database migrations.  
* quickstart     Run both 'web' and 'worker' together, auto-wired. Not recommended for production.  
  retire-worker  Safely remove a worker from the cluster permanently.  
  web            Run the web UI and build scheduler.  
  worker         Run and register a worker.  



## Set up local Concourse via docker-compose

```console
bash install-ci.sh [host ip] [dns with quota]
```


## Login to local Concourse via fly-cli as "test" user

After login via fly-cli, the token is saved in ~/.flyrc

```console
fly -t targetName login -c http://[host ip]:8080 -u test -p test
cat ~/.flyrc
targets:
  targetName:
    api: http://[host ip]:8080
    team: main
    token:
      type: bearer
      value: xxxxxxxxxxxxxxxxAAAAAA
```
