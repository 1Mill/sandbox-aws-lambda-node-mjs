# sandbox-aws-lambda-node-mjs

## Invoking locally

1. `docker compose up --build lambda`
2. `./scripts/invoke.bash`
3. `docker compose up mongo-admin`
4. Visit <http://localhost:9001>

## Deploying to AWS

1. `docker compose run terraform init`
2. `docker compose run terraform apply -auto-approve`
3. `docker compose run terraform destroy -auto-approve`
