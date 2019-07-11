set <INSERT-REGISTRY> in the values.yaml file to your docker registry and also set it in .env

source .env

REGISTRY=$REGISTRY make build

REGISTRY=$REGISTRY make push

make run
