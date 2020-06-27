# docker-ssh

This is a little wrapper script for the docker client cli, that parses all arguments for exposed ports and forwards those ports to your machine using ssh.

## But why?!

In my development workflow, i rely heavily on WSL2 and docker. But after running into limitations with 'Docker for desktop' i decided to use a hyper-v linux vm running the docker daemon instead. Having gotten used to docker for desktop, i realised that when exposing ports with the `-p port:port` argument, those ports are no longer accesible on my host machine and are instead exposed on the remote machine.

## Limitations

- this script is at this point only very rudimentary, and makes plenty of assumptions about your environment
    - assumes your DOCKER_HOST env variable is in the following form scheme://host:port, otherwise it will use the default hostname `dockerd`
    - assumes you can access your docker host via ssh with your current user
- might break with your docker commands (but works good enough for my use cases)
    - as i'm too lazy to parse arguments properly, it simply matches every argument that uses the following for `port_num:whatever`
    - does absolutely not work when using `-P` (that might get implented at some point)
    - Ports will get closed immediately if you run your container with `-d` or `--detach`

## Installation

```
curl -sLO https://github.com/asnapper/docker-ssh/releases/download/0.0.1/docker-ssh-0.0.1_all.deb && sudo dpkg -i docker-ssh-0.0.1_all.deb && sudo apt-get install -f
```

## Usage

exactly like you would the regular docker-cli

```
docker-ssh run -p 8080:80 -p 8443:443 --rm -t mendhak/http-https-echo
```

## Disclaimer

might eat your babies! Use at your own risk