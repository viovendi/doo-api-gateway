SHELL:=/bin/bash
AWS_PROFILE=doo

docs-build:
	npm install
	npm run build

docs-deploy:
	aws s3 rm s3://dev.doo.net/ --recursive --region eu-central-1
	aws s3 cp ./dist s3://dev.doo.net/ --recursive --region eu-central-1

api-update:
	aws apigateway put-rest-api --rest-api-id s39cilwfik --mode overwrite --body 'file://doo-swagger.json' --region eu-central-1