DEBUG ?= true
ENV_MODE ?= dev
INSTANCE ?= dev # TODO
VERSION ?= ${INSTANCE} # TODO

env-config:
	@echo DEBUG: ${DEBUG}
	@echo ENV_MODE: ${ENV_MODE}
	@echo INSTANCE_NAME: ${INSTANCE_NAME}
	@echo VERSION: ${VERSION}

run-compose: project-name := sassenhora-dcare-${INSTANCE}
run-compose: stack := -f stack.yaml -f stack-${ENV_MODE}.yaml
run-compose: env-vars := DEBUG=${DEBUG}
run-compose: env-vars += INSTANCE=${INSTANCE}
run-compose: env-vars += VERSION=${VERSION}
run-compose:
	${env-vars} docker-compose -p ${project-name} ${stack} ${command}

compose-config: command := config
compose-config: run-compose

build: command := build ${service}
build: run-compose

test-features: command := run features 'composer run tests'
test-features: run-compose

dev-up: command := up -d -V --build
dev-up: run-compose

dev-ps: command := ps
dev-ps: run-compose

dev-logs: command := logs -f
dev-logs: run-compose

dev-down: command := down -v
dev-down: run-compose

dev-exec: command := exec ${service} ${run}
dev-exec: run-compose

dev-bash: command := exec ${service} bash
dev-bash: run-compose
