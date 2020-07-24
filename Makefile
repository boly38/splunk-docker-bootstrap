# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

volumes: ## create splunk volumes
	docker volume create splunk-var
	docker volume create splunk-etc

volumesDown: ## delete splunk volumes
	docker volume remove splunk-var
	docker volume remove splunk-etc

pull: ## pull splunk images
	docker pull splunk/splunk:latest
	docker pull splunk/universalforwarder:6.5.0

splunkStart: ## start splunk server on localhost:8000
	docker-compose -f docker-compose-splunk.yml up -d

splunkStop: ## stop splunk server
	docker-compose -f docker-compose-splunk.yml stop

splunkDown: ## remove splunk server
	docker-compose -f docker-compose-splunk.yml down

forwarderStart: ## start splunk forwarder
	docker-compose -f docker-compose-forwarder.yml up -d

forwarderStop: ## start splunk forwarder
	docker-compose -f docker-compose-forwarder.yml stop

forwarderDown: ## remove splunk forwarder
	docker-compose -f docker-compose-forwarder.yml down

ps: ## list docker containers and names, status, and ids
	docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.ID}}\t{{.Ports}}"