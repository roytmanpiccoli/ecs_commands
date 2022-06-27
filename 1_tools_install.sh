# Install jq, as we will use this quite a bit throughout the workshop when interacting with json outputs.
sudo yum install -y jq

# Upgrade AWS CLI according to guidance in AWS documentation.

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo rm awscliv2.zip

#  To ensure temporary credentials aren’t already in place we will remove any existing credentials file as well as disabling AWS managed temporary credentials for Cloud9
aws cloud9 update-environment  --environment-id $C9_PID --managed-credentials-action DISABLE
rm -vf ${HOME}/.aws/credentials

# We should configure our aws cli with our current region as default.

echo "export AWS_DEFAULT_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)" >> ~/.bashrc
echo "export AWS_REGION=\$AWS_DEFAULT_REGION" >> ~/.bashrc
echo "export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)" >> ~/.bashrc
source ~/.bashrc
# Check if AWS_REGION is set to desired region

test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

# Let’s save these into bash_profile
echo "export AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
echo "export IAM_ROLE=$(aws sts get-caller-identity --query Account --output text)" >> ~/.bashrc


# Use the GetCallerIdentity CLI 

aws sts get-caller-identity --query Arn | grep "$IAM_ROLE" -q && echo "IAM role valid" || echo "IAM role NOT valid"





