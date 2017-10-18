# Run & Scale Apache Gearpump on a docker swarm cluster

Apache Gearpump

	Apache Gearpump is a lightweight real-time big data streaming engine
	
Docker Swarm

	Docker Swarm is a clustering and scheduling tool for Docker containers

## Docker Swarm + Apache Gearpump = ♥

### Deploy gearpump cluster master + 3 workers + ui

	docker stack deploy -c docker-compose.yml gearpump

#### Web UI

	http://dockerhost:8090/

#### Submitting an application

In order to submit a new application you can use the web ui or mount a volume on the master container and use the deploy command:

	bin/gear app -jar applications/your-app.jar your.main.class 

#### Scaling Workers

To scale your workers just use the docker-swarm command, new workers will be automatically configured and registered on the cluster

	 docker service scale gearpump_gearpump-worker=<Workers> 
	
### Performances

The current setup is able to reach **200.000+ msg/sec** with the base example application in a 3 nodes ( 2 core, 2 gb memory) cluster (2 workers, 1 master)
	

### Example docker swarm stack

	version: '3'

	services:

	  gearpump-master:
	    hostname: gearpump-master
	    image: garugaru/gearpump:b1880f4
	    entrypoint: ./entrypoint.sh
	    command: ./bin/master -ip gearpump-master -port 3000
	    environment:
		- MASTERS=["gearpump-master:3000"]
		- HOSTNAME=gearpump-master    
	    deploy:
		mode: replicated
		replicas: 1

	  gearpump-ui:
	    image: garugaru/gearpump:b1880f4
	    entrypoint: ./entrypoint.sh
	    command: ./bin/services
	    environment:
		- MASTERS=["gearpump-master:3000"]
	    ports:
	      - "8090:8090"
	    depends_on:
		- gearpump-master
	    deploy:
		mode: replicated
		replicas: 1

	  gearpump-worker:
	    hostname: "{{.Node.Hostname}}"
	    entrypoint: ./entrypoint.sh
	    image: garugaru/gearpump:b1880f4
	    command: ./bin/worker 
	    environment:
		- MASTERS=["gearpump-master:3000"] 
	    depends_on:
		- gearpump-master
		- gearpump-ui
	    deploy:
		mode: replicated
		replicas: 3
