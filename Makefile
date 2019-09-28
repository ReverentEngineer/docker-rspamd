DOCKER_TAG=reverentengineer/rspamd

build:
	docker build -t $(DOCKER_TAG) .

deploy:
	docker push $(DOCKER_TAG)
