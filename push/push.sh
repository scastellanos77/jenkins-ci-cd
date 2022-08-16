#!/bin/sh

echo "########################"
echo "*** Preparing to push ***"
echo "########################"

REGISTRY="https://index.docker.io/v1/"
IMAGE="app"

echo "*** Logging in ***"
docker login -u scastell77 -p $PASS $REGISTRY

echo "*** Tagging image ***"
docker tag $REGISTRY/$IMAGE:$BUILD_TAG $REGISTRY/$IMAGE:$BUILD_TAG

echo "*** Pushing image ***"
docker push $REGISTRY/$IMAGE:$BUILD_TAG
