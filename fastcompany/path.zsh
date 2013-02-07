# ----------------------------------------------------------------------
# JAVA HOME FOR AWS
# ----------------------------------------------------------------------
export JAVA_HOME=$(/usr/libexec/java_home)

export EC2_PRIVATE_KEY=~/.ssh/michael.shick@gmail.com.pem
export EC2_CERT=~/.ssh/michael.shick@gmail.com_cert.pem
export AWS_CREDENTIAL_FILE=~/.aws-credentials

export REPOS=~/Repositories
export FC_REPO=$REPOS/fastcompany
export FC_LIB=$FC_REPO/infrastructure/lib
export FC_TOOLS_HOME=$FC_REPO/infrastructure/fc_tools
export FC_AWS_HOME=$FC_REPO/infrastructure/fc_aws
export AWS_ELB_HOME=$FC_LIB/aws-elb
export EC2_HOME=$FC_LIB/aws-ec2
export AWS_AUTO_SCALING_HOME=$FC_LIB/aws-autoscaling
export AWS_CLOUDWATCH_HOME=$FC_LIB/aws-cloudwatch
export AWS_RDS_HOME=$FC_LIB/aws-rds
export PATH=$AWS_ELB_HOME/bin:$EC2_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$AWS_CLOUDWATCH_HOME/bin:$AWS_RDS_HOME/bin:$PATH
export PATH=$FC_LIB:$FC_TOOLS_HOME/bin:$FC_AWS_HOME/bin:$PATH
export FCAWS_PROXY_HOST=gate.fast-co.net
export FCAWS_PROXY_HOST_REGION=us-east-1
export EC2_URL=http://ec2.us-east-1.amazonaws.com

# ----------------------------------------------------------------------
# JETPACK
# ----------------------------------------------------------------------
export THANKSJETPACK=$FC_REPO/thanks-jetpack
export PATH=$THANKSJETPACK/bin:$PATH
