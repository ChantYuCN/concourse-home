# CI concourse



## Set up local Concourse via docker-compose

```console
bash install.sh [host ip] [dns with quota]
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
