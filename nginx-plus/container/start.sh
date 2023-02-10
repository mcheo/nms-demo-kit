#!/bin/bash

#nginx -g "daemon off;"
nginx
sleep 2

if [ ! -z "$ACM_DEVPORTAL" ] && [ $ACM_DEVPORTAL == "true" ]; then
   nginx-devportal server &
fi

PARM="--server-grpcport $NIM_GRPC_PORT --server-host $NIM_HOST"

if [[ ! -z "$NIM_INSTANCEGROUP" ]]; then
   PARM="${PARM} --instance-group $NIM_INSTANCEGROUP"
fi

if [[ ! -z "$NIM_TAGS" ]]; then
   PARM="${PARM} --tags $NIM_TAGS"
fi

nginx-agent $PARM

