# standard info
PROJECT = app
REGISTRY = registry.giantswarm.io
USERNAME :=  $(shell swarm user)
DOMAIN = app-$(USERNAME).gigantic.io
VAR_1 = foo
VAR_2 = bar

# local info
MY_IP = $(shell boot2docker ip)

docker-build:
	docker build -t $(REGISTRY)/$(USERNAME)/$(PROJECT) .

docker-run: docker-build
	@echo "Your app is running at http://$(MY_IP):8000"
	docker run --rm -ti \
		-e "VAR_1=$(VAR_1)" \
		-e "VAR_2=$(VAR_2)" \
		-p 8000:8000 \
		$(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-push: docker-build
	docker push $(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-pull:
	docker pull $(REGISTRY)/$(USERNAME)/$(PROJECT)

swarm-up: docker-push
	swarm up \
	  --var=var_1=$(VAR_1) \
	  --var=var_2=$(VAR_2) \
	  --var=domain=$(DOMAIN)
	@echo "Your app is running at http://$(domain)"
