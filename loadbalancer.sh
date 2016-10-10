#!/bin/bash
#1: check the subnet value: 
#COPY subnet-d1d0aba7
#2: crEATE LOAD BALANCER.
aws elb create-load-balancer --load-balancer-name itmo544shyamload --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-d1d0aba7 
#delete load-balancer-name aws elb delete-load-balancer --load-balancer-name itmo544shyam
#3: launch configuration in auto scaling group
aws autoscaling create-launch-configuration --launch-configuration-name itmo544shyamconfig --image-id ami-06b94666 --security-group sg-a0ac79d9 --key-name bootstrap.pem --instance-type t2.micro --user-data file://hello.sh
#TO GET THE KEY PAIR NAME TYPE aws ec2 describe-key-pairs: to get the security group type: aws ec2 describe-security_groups
#4: creating autoscaling
aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration itmo544shyamconfig --availability-zone us-west-2b --load-balancer-name itmo544shyamload --max-size 5 --min-size 2 --desired-capacity 3
