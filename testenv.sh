#!/bin/bash

source env.sh

sed -i -e "s/BASE_IMAGE/${BASE_IMAGE}/g" Dockerfile
sed -i -e "s/ARTIFACT_NAME/${ARTIFACT_NAME}/g" Dockerfile
sed -i -e "s/APPLICATION_PORT_0/${APPLICATION_PORT_0}/g" Dockerfile
sed -i -e "s/APPLICATION_PORT_1/${APPLICATION_PORT_1}/g" Dockerfile


