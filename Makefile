SHELL = /bin/bash
CURRENT_DIR = $(shell pwd)
REGISTRY ?= youshouldprovidethis

run: init install

build:
	${SHELL} ${CURRENT_DIR}/airflow-kube-helm/examples/kube/docker/build-docker.sh k8sexec latest
	docker tag k8sexec:latest ${REGISTRY}/k8sexec:latest

push:
	docker image push ${REGISTRY}/k8sexec:latest

init:
	helm init --tiller-namespace development
	helm dependencies --tiller-namespace development update ${CURRENT_DIR}/airflow-kube-helm/airflow/.

install:
	helm upgrade \
		--install \
		--tiller-namespace development \
		--debug \
		--namespace development \
		--values ${CURRENT_DIR}/values.yaml \
		slocke  \
		${CURRENT_DIR}/airflow-kube-helm/airflow/ \
		--wait \
		--timeout 1200

uninstall:
	helm delete \
		--purge \
		--tiller-namespace development \
		slocke