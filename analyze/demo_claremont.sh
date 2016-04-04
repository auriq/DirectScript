#!/bin/bash
###a tutorial for s3 public data repository##################
###essentia working directly on raw data in compressed or 
###archived format###########################################
###AuriQ Systems provides a read-only key for demo purpose###

######First, please dump credentials to the right path######
echo "Please copy credential csv files to the following path"
echo $ESS_AWS_DIR
echo " "
echo "#######################################################"

echo "#####################################################################"
echo "command 1 ess select: connecting to a working data repository"
ess select s3://asi-essentiapublic --credentials $ESS_AWS_DIR/demo_essentiaPublic.csv

####list files in home (root) directory#####
echo "#####################################################################"
echo "command 2 ess ls: list files in home dir###"
ess ls

###list files in a subdir#############
echo "#####################################################################"
echo "command 3 ess ls /dir: list files in a subdir"
ess ls dateformat

###list files in a archive###
echo "#####################################################################"
echo "command 4 ess lsa: list files in a tar archive"
ess lsa dateformat/gsod.1940-01-01.tar.bz2

###using category to group files####
echo "#####################################################################"
echo "command 5 ess category add: define a working category"
ess category add climate 'dateformat/gsod.1940-01-01.tar.bz2' --dateregex='[:%Y:]-[:%m:]-[:%d:]' --preprocess='logcnv -f,+1,eok,qui - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt' --overwrite

###show summary of category#####
echo "#####################################################################"
echo "command 6 ess summary: show category summary"
ess summary climate

###SQL-query raw data#####
echo "#####################################################################"
echo "command 7 ess query: query category with tarred bz2 files"
ess query 'select count(distinct stn) from climate:*:*'

###streaming first few lines######
echo "#####################################################################"
echo "command 8 ess stream: print out the first 5 lines of category"
ess stream climate 1940-01-01 '*' 'head -5'

###write to a csv file###########
echo "#####################################################################"
echo "command 9 ess stream '*' '*' 'aq_pp...': stream data to aq_pp,output .csv"
ess stream climate '*' '*' 'aq_pp -f,+1r,eok - -d %cols -o climate.csv' --master

###show first 5 lines of climate.csv'
echo "#####################################################################"
echo "command 10 ess cat: show the first 5 lines of output saved on local disk"
ess select local
ess cat /var/www/html/mydmp/aws/1/.job/climate.csv --label local | head -5

###delete demo output################
rm /var/www/html/mydmp/aws/1/.job/climate.csv
