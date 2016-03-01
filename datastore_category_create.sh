#!/bin/bash

## This script demos:
##1) how to purge a datastore - ess purge
##2) how to choose a datastore - ess select
##3) how to view files/directories in the selected datastore - ess ls
##4) how to view a compressed file -- ess lsa
##5) how to create a category -- ess category add
##6) how to modify some category attributes -- ess category change
##7) how to summarize datastore, category -- ess summary
#####first make sure credential csv file is saved######
echo "credential csv files are saved here"
credenPath=`pwd`/.aws
echo $credenPath

echo "Command 1: delete a pre-existing datastore with the same name"
ess purge asi-essentiapublic

echo "########################################"
echo "####Command 2: select a s3 datastore####"
ess select s3://asi-essentiapublic --credentials $credenPath/demo_essentiaPublic.csv 

echo "#########################################################################"
echo "####Command 3: list all files and directories in the parent directory####"
ess ls

echo "###################################################################"
echo "####Command 4: list all files and directories in a subdirectory####"      
ess ls climate

echo "#######################################################"
echo "####Command 5: list files in all subdir recursively####"              
ess ls -r

echo "##############################################"
echo "####Command 6: list files in a tar archive####"              
ess lsa filetypes/all.tar.gz

echo "##############################################"
echo "####Command 7: list files in a zip archive####"              
ess lsa filetypes/b.zip      

echo "######################################################################"
echo "####Command 8: list files with a specific pattern in a tar archive####"              
ess lsa filetypes/climate.tar.bz2 --pattern '*011470*'

echo "#########################################################"
echo "####Command 9: create a category with default options####"            
ess category add default 'climate'

echo "#####################################################################"
echo "####Command 10: create a category with a given dateregex formatter####"
ess category add ageregex 'dateformat/Dec-31-2015_age_gender.csv' --dateregex='[:%b:]-[:%d:]-[:%Y:]'

echo "#####################################################################"
echo "####Command 11: create a category with a given dateregex formatter####"
ess category add log 'dateformat/20140701000006pm.log' --dateregex='[:%Y:][:%m:][:%d:]'

echo "#####################################################################"
echo "####Command 12: create a category with a given dateformat formatter####"
ess category add log1 'dateformat/20140701000006pm.log' --dateformat='YMD'

echo "####################################################"
echo "####Command 13: create a category with preprocess####"                     
ess category add climate 'climate/01*.op' --dateregex='-[:%Y:]' --preprocess='logcnv  -f,+1,eok - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt -o,notitle -'

echo "########################################################"
echo "####Command 14: overwrite a category with preprocess####"                  
ess category add log 'dateformat/20140701000006pm.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]' --preprocess='logcnv -f,eok,qui - -d ip:ip sep:" " s:rlog sep:" " s:rusr sep:" [" i,tim:time sep:"] \"" s,clf:req_line1 sep:" " s,clf:req_line2 sep:" " s,clf:req_line3 sep:"\" " i:res_status sep:" " i:res_size sep:" \"" s,clf:referrer sep:"\" \"" s,clf:user_agent sep:"\""' --overwrite

echo "############################################################################"
echo "####Command 15: modify category column specific, make all column strings####"
ess category change columnspec climate --alls

echo "##############################################"
echo "####Command 16: modify dateregex formatter####"
ess category change dateregex log '[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]'

echo "##########################################"
echo "####Command 17: show datastore summary####"
ess summary

echo "##########################################"
echo "####Command 18: show category summary####"
ess summary log
