#!/bin/bash

#####this cluster set up assume your instance######
#####is launched with IAM ROlES, if not, please####
#####see cluster_credentials.sh####################

echo "####command1: setting up clusters##########################"
ess cluster set cloud

echo "####command2: setting up clusters##########################"
ess cluster create --num=2 

echo "####command3: check cluster status#########################"
ess cluster status

echo "####command4: terminate clusters###########################"
ess cluster terminate


