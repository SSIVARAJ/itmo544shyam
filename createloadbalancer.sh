#!/bin/bash
#creating load balancer name given by user
echo -n "enter the loadbalancer name:"
read input
aws elb create-load-balancer --load-balancer-name $input --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-d1d0aba7
# Enter the AMI ID, KEY-NAME
echo -n "enter the AMI ID:"
read input_ami
echo -n "enter KEY-NAME:"
read input_keyname
echo -n "enter sercurity groups"
read input_security
aws autoscaling create-launch-configuration --launch-configuration-name itmo544shyamconfig --image-id $input_ami --security-group $input_security --key-name $input_keyname --instance-type t2.micro --user-data file://hello.sh
#echo "value is $input_loadbalancername"
