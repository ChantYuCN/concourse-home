# Service

8085: consourse  
8086: gitea  
5000: docker-registry  
8089: argocd  
8000: api-gateway  
9000: traefik  

# Pre-Request

Please do time sync for prometheus

# CI

reserve port 8085 8086 5000 8089 8000 9000   

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
fly -t targetName login -c http://[host ip]:8085 -u test -p test
cat ~/.flyrc
targets:
  targetName:
    api: http://[host ip]:8085
    team: main
    token:
      type: bearer
      value: xxxxxxxxxxxxxxxxAAAAAA
```

# CD

reserve port 8083 9000  

argocd  

Run install-cd.sh for simple env.  

## Set up local argocd via microk8s

```console
bash install-cd.sh [host ip] [optional - full deploy yes/no]
...
admin password
9kl8Fygn6SPOGUaV

 This password must be only used for first time login. We strongly recommend you update the password using `argocd account update-password`.
```

