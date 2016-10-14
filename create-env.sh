#!/bin/bash
#creating load balancer name given by user

if [ "$#" -ne 5 ]; then
   echo "Missing parameters"
   echo -n "the paramters should be in this format:"
   echo -n " 1) AMI ID: ami-06b94666"
   echo -n "2)KEY-NAME: bootstrap.pem" 
   echo -n "3)security-group: sg-a0ac79d9 "
   echo -n "4) launch-configuration: ANy NAME"
   echo -n "5) COUNT: NUmber of instance numeric value, minimum 2 maximum 5"
   exit 0
else
echo "all parameters are present"
fi

aws elb create-load-balancer --load-balancer-name itmoloadbalancershyam --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-d1d0aba7

aws autoscaling create-launch-configuration --launch-configuration-name $4 --image-id $1 --security-group $3 --key-name $2 --instance-type t2.micro --user-data file://hello.sh

aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration $4 --availability-zone us-west-2b --load-balancer-name itmoloadbalancershyam  --max-size 5 --min-size 2 --desired-capacity $5
echo "creating instances................"
