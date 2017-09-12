SHELL:=/bin/bash

build-docs:
	npm install
	npm run build

deploy-docs:
	export AWS_PROFILE=doo
	aws s3 rm s3://dev.doo.net/ --recursive --region eu-central-1
	aws s3 cp ./dist s3://dev.doo.net/ --recursive --region eu-central-1