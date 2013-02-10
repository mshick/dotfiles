# ----------------------------------------------------------------------
# Java home for AWS
# ----------------------------------------------------------------------
if [ -z $JAVA_HOME ];
then
  java_home=/usr/libexec/java_home;
  if [[ -f $java_home ]];
  then
    export JAVA_HOME=$($java_home);
  else
    echo "You MUST install Java to use AWS tools!";
  fi
fi

# ----------------------------------------------------------------------
# FC AWS Infrastructure
# ----------------------------------------------------------------------

if [ -z $FC_REPO ];
  then export FC_REPO=$PROJECTS/fastcompany
fi

export FC_LIB=$FC_REPO/infrastructure/lib
export FC_TOOLS_HOME=$FC_REPO/infrastructure/fc_tools
export FC_AWS_HOME=$FC_REPO/infrastructure/fc_aws
export AWS_ELB_HOME=$FC_LIB/aws-elb
export EC2_HOME=$FC_LIB/aws-ec2
export AWS_AUTO_SCALING_HOME=$FC_LIB/aws-autoscaling
export AWS_CLOUDWATCH_HOME=$FC_LIB/aws-cloudwatch
export AWS_RDS_HOME=$FC_LIB/aws-rds
export EC2_URL=http://ec2.us-east-1.amazonaws.com

PATH=$AWS_ELB_HOME/bin:$EC2_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$AWS_CLOUDWATCH_HOME/bin:$AWS_RDS_HOME/bin:$PATH
PATH=$FC_LIB:$FC_TOOLS_HOME/bin:$FC_AWS_HOME/bin:$PATH

# ----------------------------------------------------------------------
# JETPACK
# ----------------------------------------------------------------------
export THANKSJETPACK=$FC_REPO/thanks-jetpack

PATH=$THANKSJETPACK/bin:$PATH
