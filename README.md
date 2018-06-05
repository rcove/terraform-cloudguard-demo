# terraform-cloudguard-demo
Two-Tier AWS Secure Architecture demo, SIaC 
Demo code for provisioning a two-tier architecture consisting on a loadbalanced autoscale group of Check Point security gateways and a loadbalanced autoscale group of web servers
This example will create a new EC2 Key Pair in the specified AWS Region. The key name and path to the public key must be specified via the terraform variables file.
Finally the code will register the external LB IP address into a route53 existing zone.
After you run "terraform apply" on this configuration, it will automatically output the DNS address of URL registered according to the variables defined in the variables.tfvars file.
This architecture relies on an existing Check Point management server where autoregistration is already configured to monitor the same AWS subscription.
After your instances are registered, the registered DNS record will respond with a demo web page.
To run, configure your AWS provider as described in
https://www.terraform.io/docs/providers/aws/index.html
Also make sure you edit the terraform.tfvars file to include your key and any other parameter you want to customize for your environment.
Run with a command like this:
  terraform apply 
 
Preparing for the terraform demo, additional instructions

In the AWS IAM portal, create a new IAM user see sk112575 and https://www.terraform.io/docs/providers/aws/index.htm 
Can use the same user for both terraform and the SMS setup
In route53, find and register a domain, (this can take 24 hours) 

On the Linux machine that you are running terraform;
	Add the created AWS env variables to .bashrc (use sample bashrc.txt)
	
Download terraform https://www.terraform.io/downloads.html 
Download demo setup files in the zip (or from github) to a directory 
Modify terraform.tfvars file to suite the environment
Run the following fixing errors as you go
terraform init
terraform plan 
terraform apply 
   when finished 
terraform destroy

On the SMS (Smartcenter)
Command line, expert 
# vsec on
GUI
Create a datacenter object for AWS called AWS_Sydney (same one as in autoprov-cfg)
Create a simple policy called Scalepolicy (same one as in autoprov-cfg) to install on the autoscale setup
Publish changes

Command line expert, setup autoscale 
See sk112575 “(4-B) Configure the Check Point Management Server for autoscale automation”
	
# autoprov-cfg init AWS -mn R80Mgmt -tn Demo-terraform-scale -otp vpn12345 -ver R80.10 -po Scalepolicy -cn AWS_Sydney -r ap-southeast-2 -ak AxxxxxxxxxxxQ -sk ZxxxxxxxxxS

# autoprov-cfg set template -tn Demo-terraform-scale -appi -uf -pp 8080 -hi -ips -ab -av -ia

# service autoprovision restart  
# service autoprovision test 

To test run the file from a linux server connectiontest.sh until it exits, at this point the website is ready to go. 
Then connect from a GUI browser

Troubleshooting 
Check the instances have been created and are correctly tagged with x-chkp-tags
Check the autoscale group, as well as the status of the Loadballancer 
Test autprovision script as above 
Check all names match in scripts and settings and DataCenter object
Make sure you have a policy with the correct name in the SMS 

