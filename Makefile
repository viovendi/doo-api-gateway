SHELL:=/bin/bash

# Current AWS profile
export AWS_PROFILE=doo

#
# To deploy API docs:
# 1. make docs-build
# 2. make docs-deploy
#

# Build API docs
docs-build:
	npm install
	npm run build

# Deploy API docs to S3
docs-deploy:
	aws s3 rm s3://dev.doo.net/ --recursive --region eu-central-1
	aws s3 cp ./dist s3://dev.doo.net/ --recursive --region eu-central-1

#
# To deploy Swagger File:
# 1. make api-update
# 2. make api-deploy STAGE=<stage_name> DESCRIPTION='<description>'
#

# Import Swagger File to API Gateway
api-update:
	aws apigateway put-rest-api --rest-api-id s39cilwfik --mode overwrite --body 'file://doo-swagger.json' --region eu-central-1

# Deploy API configuration to specified stage
api-deploy:
	aws apigateway create-deployment --rest-api-id s39cilwfik --stage-name $(STAGE) --description '$(DESCRIPTION)' --region eu-central-1

#
# Additional commands
#

version-show:
	git tag

version-add:
	git tag $(VERSION)
	git push origin --tags