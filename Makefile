# standard info
PROJECT = ipfs
REGISTRY = registry.giantswarm.io
USERNAME :=  $(shell swarm user)
IPFS_DOMAIN = ipfs-$(USERNAME).gigantic.io
API_DOMAIN = api-$(USERNAME).gigantic.io
API_PORT = 5001
IPFS_PORT = 4001
GATEWAY_PORT = 8080
MACHINE = default

# local info
MY_IP = $(shell docker-machine ip $(MACHINE))
# MY_IP = $(shell boot2docker ip)

build:
	docker build -t $(REGISTRY)/$(USERNAME)/$(PROJECT) .

run: build
	@echo "##########################################################################"
	@echo "Your service $(PROJECT) will be running at http://$(MY_IP):$(PORT)/"
	@echo "##########################################################################"

	docker run --rm -ti \
		-p $(API_PORT):$(API_PORT) \
		-p $(IPFS_PORT):$(IPFS_PORT) \
		-p $(GATEWAY_PORT):$(GATEWAY_PORT) \
		$(REGISTRY)/$(USERNAME)/$(PROJECT)

push: build
	docker push $(REGISTRY)/$(USERNAME)/$(PROJECT)

pull:
	docker pull $(REGISTRY)/$(USERNAME)/$(PROJECT)

up: push
	swarm up \
	  --var=api_domain=$(API_DOMAIN) \
	  --var=ipfs_domain=$(IPFS_DOMAIN) \
	  --var=org=$(USERNAME) \
	  --var=ipfs_port=$(IPFS_PORT) \
	  --var=api_port=$(API_PORT)
	  --var=name=$(PROJECT)

	@echo "##########################################################################"
	@echo "Your service '$(PROJECT)' is running at http://$(API_DOMAIN)/webui"
	@echo "##########################################################################"
