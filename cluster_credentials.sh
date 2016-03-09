#!/bin/bash

#####if you are using credential files#######
#####please copy the file to $ESS_AWS_DIR###
############################################

printf "%s %s" "Copy credentials to" $ESS_AWS_DIR"

ess cluster set cloud

ess cluster create --num=2 --credentials $ESS_AWS_DIR/credentials
###alternative method:###############################################
##ess cluster create --num=2 --aws_access_key [your_access_key] --aws_secret_access_key [your_secret key]###

ess cluster status

ess cluster terminate


