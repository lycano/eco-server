# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

ECO_VERSION ?= 0.7.4.6-beta
DOCKER_HOME ?= ~
SERVER_NAME ?= eco-server
DOCKER_IMAGE ?= lycano/eco-server

DOCKER_TARGET = ${DOCKER_IMAGE}:${ECO_VERSION}

all: build push clean

build:
	docker build --rm \
	--label "eco.version=${ECO_VERSION}" \
	--build-arg ECO_VERSION="${ECO_VERSION}" \
	-t ${DOCKER_TARGET} \
	-t ${DOCKER_IMAGE} \
	.

push:
	docker push ${DOCKER_IMAGE}

clean:
	rm -rf "${ECO_FILENAME}"

run:
	mkdir -p "${DOCKER_HOME}/${SERVER_NAME}/Storage" "${DOCKER_HOME}/${SERVER_NAME}/Configs" "${DOCKER_HOME}/${SERVER_NAME}/Mods" && \
	docker run -it -d --name "${SERVER_NAME}" \
	-p=127.0.0.1:3000:3000/udp \
	-p=127.0.0.1:3001:3000 \
	-v ${DOCKER_HOME}/${SERVER_NAME}/Storage:/srv/eco-server/Storage \
	-v ${DOCKER_HOME}/${SERVER_NAME}/Configs:/srv/eco-server/Configs \
	-v ${DOCKER_HOME}/${SERVER_NAME}/Mods:/srv/eco-server/Mods \
	${DOCKER_TARGET}
