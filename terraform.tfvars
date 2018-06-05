# Adjust vars for the AWS settings and region
# These VPCs, subnets, and gateways will be created as part of the demo
public_key_path = "~/.ssh/id_rsa.pub"
aws_region = "ap-southeast-2"
key_name = "azure_pub_key2"
aws_vpc_cidr = "10.30.0.0/16"
aws_external1_subnet_cidr = "10.30.1.0/24"
aws_external2_subnet_cidr = "10.30.2.0/24"
aws_webserver1_subnet_cidr = "10.30.10.0/24"
aws_webserver2_subnet_cidr = "10.30.20.0/24"
cg_size = "c4.large"
ws_size = "t2.micro"
r53zone = "mycloudguard.net."
externaldnshost = "siac-demo"
SICKey = "vpn12345"
AllowUploadDownload = "true"
pwd_hash = "$1$8SfURQQf$dXRtRJQX8cFPg25NTqv9T0"

my_user_data = <<-EOF
                #!/bin/bash
                clish -c 'set user admin shell /bin/bash' -s
                blink_config -s 'gateway_cluster_member=false&ftw_sic_key=vpn12345&upload_info=true&download_info=true&admin_hash="$1$8SfURQQf$dXRtRJQX8cFPg25NTqv9T0"'		
                addr="$(ip addr show dev eth0 | awk "/inet/{print \$2; exit}" | cut -d / -f 1)"
                dynamic_objects -n LocalGateway -r "$addr" "$addr" -a
                EOF

ubuntu_user_data = <<-EOF
                    #!/bin/bash
                    until sudo apt-get update && sudo apt-get -y install apache2;do
                      sleep 1
                    done
                    until curl \
                      --output /var/www/html/CloudGuard.png \
                      --url https://www.checkpoint.com/wp-content/uploads/cloudguard-hero-image.png ; do
                       sleep 1
                    done
                    sudo chmod a+w /var/www/html/index.html 
                    echo "<html><head><meta http-equiv=refresh content=2;'http://siac-demo.mycloudguard.net/' /> </head><body><center><H1>" > /var/www/html/index.html
                    echo $HOSTNAME >> /var/www/html/index.html
                    echo "<BR><BR>Check Point CloudGuard SIaC Demo <BR><BR>Any Cloud, Any App, Unmatched Security<BR><BR>" >> /var/www/html/index.html
                    echo "<img src=\"/CloudGuard.png\" height=\"25%\">" >> /var/www/html/index.html
                    EOF
