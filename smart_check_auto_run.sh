#!/bin/bash
eksctl create cluster -f smartcheck-cluster-config.yml 2> /dev/null
RESULT=$?
if [ $RESULT == 1 ]; then
    eksctl delete cluster --region=us-east-1 --name=smartcheck
else
    ./smartcheckon
    export SERVICE_IP=$(kubectl get svc proxy -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    echo Smart Check URL: https://$SERVICE_IP:443/
fi
