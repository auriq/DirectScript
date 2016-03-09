#!/bin/bash

#####This cluster set up only works####
#####if instance is launched with IAM##
#####roles, otherwise, please using ###
#####cluster_credential.sh#############
ess cluster set cloud

ess cluster create --num=2 

ess cluster status

ess cluster terminate


