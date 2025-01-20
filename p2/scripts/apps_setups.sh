#!/bin/bash

sudo kubectl apply -f /vagrant/configs/app_one.yaml 

sudo kubectl apply -f /vagrant/configs/app_two.yaml

sudo kubectl apply -f /vagrant/configs/app_three.yaml

sudo kubectl apply -f /vagrant/configs/ingress.yaml

while [ -z $external_ip ]; do echo "Waiting ingress to receives an external IP ....";
external_ip=$(sudo kubectl get ing iot-ingress --output="jsonpath={.status.loadBalancer.ingress[0].ip}");
[ -z "$external_ip" ] && sleep 10;
done;
echo "Ingress is ready with the external_ip: ${external_ip}"