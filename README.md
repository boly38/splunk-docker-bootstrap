# Splunk docker bootstrap

*Mount a splunk server and see your app logs in 5 minutes (out-of-pull download time).*

This project is
- a minimal quick splunk docker bootstrap 
- `docker compose` based 
- a running splunk server 
- a simple app producing syslogs forwarded to splunk via udp
- a simple app2 producing log files forwarded to splunk via shared volume

This project is not
- an advanced usage of splunk,
- an official splunk documentation.

## requirement
- docker
- `make` command 


 tips: you can add `make` to git bash for windows [here](https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058).
 And `Makefile` is easy to read, you can just pick docker commands.

## HowTo setup splunk server

- create storage (docker volume)

```
make volumes
```
- (optional) pull last docker images

```
make pull
```

- create splunk server

```
make splunkStart
```
- monitor splunk startup (tail logs)
```
docker logs -f splunk
# CTRL + C to leave
```
*once started, you could*
 
- connect splunk at [localhost:8000](http://admin:splunk1234@localhost:8000) (admin/splunk1234)
- go to `Parameters` / `Index` / `New index` to add following indexes:
  1) name `docker_udp` of `50` Mo size.
  2) name `docker_file` of `50` Mo size.
- click on `save`

## HowTo setup splunk forwarder and apps
- start splunk forwarder and alpine samples that generates logs
```
make forwarderStart
docker logs splunk_fwd
```

- then check splunk
 [using index='docker_udp' search](http://localhost:8000/fr-FR/app/search/search?q=search%20index%3Ddocker_udp)
 or [using index='docker_file' search](http://localhost:8000/fr-FR/app/search/search?q=search%20index%3Ddocker_file)
 
- that's it !


 tips: to get all commands just type `make`
 
 ## HowTo remove
 
 Use the following commands
```
make forwarderDown
make splunkDown
make volumesDown
```

## Other references
- [docker-splunk](https://splunk.github.io/docker-splunk/)
- docker images [splunk/splunk](https://hub.docker.com/r/splunk/splunk/) - [splunk-universalforwarder](https://hub.docker.com/r/dayreiner/splunk-universalforwarder/)
- [Splunk doc](https://docs.splunk.com/Documentation)

### Contribution
Please submit a [pull request](https://github.com/boly38/splunk-docker-bootstrap/pulls)

Activated bot:
- [houndci](https://houndci.com/)

### Support (bug, improvement)

Please use [issues](https://github.com/boly38/splunk-docker-bootstrap/issues)


