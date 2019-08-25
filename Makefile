SHELL := /bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: init plan apply test

destroy:
	@echo "Destroying"
	bash -c "terraform destroy -force"

init:
	@echo "Init"
	bash -c "terraform init -force-copy"

plan:
	@echo "Planning"
	bash -c "terraform plan"

apply:
	@echo "Applying"
	bash -c "terraform apply -auto-approve -parallelism=5"

test:
	@echo "Testing"

.DEFAULT_GOAL := all
.PHONY: all destroy plan apply test