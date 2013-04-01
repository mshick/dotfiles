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
