#!/bin/bash

#####if no IAM roles, using credential files#######
#####please copy the file to $ESS_AWS_DIR##########
############################################

printf "%s %s" "#### Please copy credentials to" $ESS_AWS_DIR 

echo "####command1: setting up clusters##########################"
ess cluster set cloud

echo "####command2: setting up clusters using credentials########"
ess cluster create --num=2 --credentials $ESS_AWS_DIR/credentials
###alternative method:###############################################
##ess cluster create --num=2 --aws_access_key [your_access_key] --aws_secret_access_key [your_secret key]###

echo "####command3: check cluster status#########################"
ess cluster status

echo "####command4: terminate clusters###########################"
ess cluster terminate


