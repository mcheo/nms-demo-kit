#!/bin/bash

# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/#docker_plus

while getopts 'ht:C:K:a:n:D' OPTION
do
	case "$OPTION" in
		t)
			IMAGENAME=$OPTARG
		;;
		n)
			NMSURL=$OPTARG
		;;
		D)
			DEVPORTAL=true
		;;
	esac
done

if [ -z "${IMAGENAME}" ]
then
        echo "Docker image name is required"
        exit
fi

if [ -z "${NMSURL}" ]
then
        echo "NGINX Instance Manager URL is required"
        exit
fi
if [ ! -z "${DEVPORTAL}" ]
then
echo "=> Building with Developer Portal support"
fi

echo "Creating image     : $IMAGENAME"

DOCKER_BUILDKIT=1 docker build --no-cache -f ./nginx-plus/Dockerfile_nplus --build-arg NMS_URL=$NMSURL --build-arg DEVPORTAL=$DEVPORTAL -t $IMAGENAME .

echo "Build complete, docker image is $IMAGENAME"
