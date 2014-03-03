DOCKER_TAG?=lightsofapollo/gaia-taskenv

default: test docker_image

node_modules: package.json
	npm install

.PHONY: test
test: node_modules test-docker
	./node_modules/.bin/mocha $(wildcard bin/*_test.js)

.PHONY: test-docker
test-docker: docker_image
	test/docker_test.sh

.PHONY: docker_image
docker_image:
	docker build -t $(DOCKER_TAG) .
