#!/bin/bash

BANNER="NGINX Management Suite Demo kit\n\n
This work leverage the official https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-nms-docker repo.\n
This tool builds a Docker image to run NGINX Management Suite\n\n
=== Usage:\n\n
$0 [options]\n\n
=== Options:\n\n
-h\t\t\t- This help\n
-t [target image]\t- The Docker image name to be created\n
-s\t\t\t- Enable Second Sight (https://github.com/F5Networks/SecondSight/) - optional\n\n
Manual build:\n\n
You may edit Dockerfile to specify the .deb package version for the required modules\n\n
-C [file.crt]\t\t- Certificate file to pull packages from the official NGINX repository\n
-K [file.key]\t\t- Key file to pull packages from the official NGINX repository\n
-A\t\t\t- Enable API Connectivity Manager\n
-W\t\t\t- Enable Security Monitoring\n\n
Automated build:\n\n
-i\t\t\t- Automated build - requires cert & key\n
-C [file.crt]\t\t- Certificate file to pull packages from the official NGINX repository\n
-K [file.key]\t\t- Key file to pull packages from the official NGINX repository\n
-A\t\t\t- Enable API Connectivity Manager\n
-W\t\t\t- Enable Security Monitoring\n\n
=== Examples:\n\n
Manual build:\n
\t$0 -t nginx-nms:2.6 -C nginx-plus/nginx-repo.crt -K nginx-plus/nginx-repo.key -A -W\n
Automated build:\n
\t$0 -t nginx-nms -i -C nginx-plus/nginx-repo.crt -K nginx-plus/nginx-repo.key -A -W\n
"

# Defaults
COUNTER=false
ACM_IMAGE=nim-files/.placeholder

while getopts 'hn:a:w:t:siC:K:AW' OPTION
do
	case "$OPTION" in
		h)
			echo -e $BANNER
			exit
		;;
		t)
			IMGNAME=$OPTARG
		;;
		s)
			COUNTER=true
		;;
		i)
			AUTOMATED_INSTALL=true
		;;
		C)
			NGINX_CERT=$OPTARG
		;;
		K)
			NGINX_KEY=$OPTARG
		;;
		A)
			ADD_ACM=true
		;;
		W)
			ADD_SM=true
		;;
		P)
			ADD_NAPC=true
		;;
	esac
done

if [ -z "$1" ]
then
	echo -e $BANNER
	exit
fi

if [ -z "${IMGNAME}" ]
then
	echo "Docker image name is required"
	exit
fi

if ([ -z "${NGINX_CERT}" ] || [ -z "${NGINX_KEY}" ])
then
	echo "NGINX certificate and key are required for automated installation"
        exit
fi

echo "==> Building NGINX Management Suite docker image"

if [ -z "${AUTOMATED_INSTALL}" ]
then
        docker build --no-cache --build-arg NGINX_CERT=$NGINX_CERT --build-arg NGINX_KEY=$NGINX_KEY --build-arg ADD_ACM=$ADD_ACM --build-arg ADD_SM=$ADD_SM --build-arg ADD_NAPC=$ADD_NAPC --build-arg BUILD_WITH_SECONDSIGHT=$COUNTER -t $IMGNAME -f Dockerfile .
else
		docker build --build-arg NGINX_CERT=$NGINX_CERT --build-arg NGINX_KEY=$NGINX_KEY --build-arg ADD_ACM=$ADD_ACM --build-arg ADD_SM=$ADD_SM --build-arg BUILD_WITH_SECONDSIGHT=$COUNTER -t $IMGNAME -f Dockerfile.automated .	
fi
