#!/bin/bash
#creating load balancer name given by user
echo -n "Enter the loadbalancer name:"
read input
if [ -z "$input" ]
	then
		while [ -z "$input" ]
		do
			echo -n "Please enter loadbalancer name again: "
			read input
		done
else
aws elb create-load-balancer --load-balancer-name $input --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-d1d0aba7

fi
# creating launch configuration
echo -n "Enter the AMI ID: "
read input_ami
if [ -z "$input_ami" ]
	then
		while [ -z "$input_ami" ]
		do
			echo -n "Please enter the AMI ID: "
			read input_ami
		done
fi

echo -n "Enter KEY-NAME: "
read input_keyname
if [ -z "$input_keyname" ]
        then
                while [ -z "$input_keyname" ]
                do
                        echo -n "Please enter the KEY-NAME: "
                        read input_keyname
                done
fi

echo -n "Enter sercurity groups: "
read input_security
if [ -z "$input_security" ]
        then
                while [ -z "$input_security" ]
                do
                        echo -n "Please enter the security group: "
                        read input_security
                done
fi
echo -n "What name you want to give for launch configuration???"
read input_launchconfig
if [ -z "$input_launchconfig" ]
        then
                while [ -z "$input_launchconfig" ]
                do
                        echo -n "Please enter the Launch configuration: "
                        read input_launchconfig
                done
fi
aws autoscaling create-launch-configuration --launch-configuration-name $input_launchconfig --image-id $input_ami --security-group $input_security --key-name $input_keyname --instance-type t2.micro --user-data file://hello.sh 
echo "launching configuration..........."

echo -n "How many instance you want to create?"
read input_instance
if [ -z "$input_instance" ]
        then
                while [ -z "$input_instance" ]
                do
                        echo -n "Please enter the number of instance you want to create: "
                        read input_launchconfig
                done
fi



aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration $input_launchconfig --availability-zone us-west-2b --load-balancer-name $input --max-size 5 --min-size 2 --desired-capacity $input_instance
echo "creating instances................"
