#!/bin/bash -ex



# Add current hostname to hosts file
tee /etc/hosts <<EOL
127.0.0.1   localhost localhost.localdomain `hostname`
EOL

for i in {1..7}
do
  echo "Attempt: ---- " $i
  yum -y update  && break || sleep 60
done

export AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
export TEST_VAR=${asg_name_data}

yum install -y git
yum install -y docker
service docker start
pip install boto3
pip install ansible
git clone https://github.com/hasindum/install-openfaas.git
echo "asg_name_data: "${asg_name_data} >> install-openfaas/extra_vars.yml
/usr/local/bin/ansible-playbook install-openfaas/site.yml --extra-vars "@install-openfaas/extra_vars.yml"