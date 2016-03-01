#!/bin/bash

###showcase the usage of multi pattern#######################
###AuriQ Systems provides a read-only key for demo purpose###

######First, please dump credentials to the right path######
echo "Please copy credential csv files to the following path"
credenPath=`pwd`/.aws
echo $credenPath
echo " "
echo "#######################################################"

echo "#####################################################################"
echo "command 1 ess select: connecting to a working data repository"
ess select s3://asi-essentiapublic --credentials $credenPath/demo_essentiaPublic.csv

####list files matching multiple patterns#####
echo "#####################################################################"
echo "command 2 ess ls: list files matching multiple patterns##############"
ess ls 'filetypes/all* dateformat climate/10[4-5]*'

###list files excluding multiple patterns####
echo "#####################################################################"
echo "command 2 ess ls: list files excluding multiple patterns##############"
ess ls  --exclude 'filetypes dateformat climate/10[4-5]* diy_woodworking/purchase*' -r

###list multiple patterns for archive mathcing################################
echo "command 3 ess lsa: list files matching multiple patterns in an archive##"
ess lsa filetypes/climate.tar.bz2 --pattern '*0114* *0115*'

###list multiple patterns for category creation##############################
echo "command 4 ess category add: multiple patterns included#################"
ess category add multiDIY 'diy_woodworking/browse* diy_woodworking/purchase_2014090[6-8]*'

###show summary of the category#############################################
echo "command 5 ess summary multiDIY########################################"
ess summary multiDIY

###list multiple patterns for category pattern exclusion#####################
echo "command 4 ess category add: multiple patterns excluded#################"
ess category add multiEXC 'diy_wood*' --exclude 'diy_woodworking/browse*[1-5]* diy_woodworking/purchase_2014090[6-8]*'

###show summary of the category#############################################
echo "command 5 ess summary multiEXC########################################"
ess summary multiEXC

