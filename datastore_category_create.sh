#!/bin/bash

## This script demos:
##1) how to choose a datastore - ess select
##2) how to view files/directories in the selected datastore - ess ls
##3) how to view a compressed file -- ess lsa
##4) how to create a category -- ess category add
##5) how to modify some category attributes -- ess category change

echo "Command 1: delete a pre-existing datastore with the same name"
ess purge asi-essentiapublic

echo "########################################"
echo "####Command 2: select a s3 datastore####"
ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "#########################################################################"
echo "####Command 3: list all files and directories in the parent directory####"
ess ls

echo "###################################################################"
echo "####Command 4: list all files and directories in a subdirectory####"      
ess ls climate

echo "#######################################################"
echo "####Command 5: list files in all subdir recursively####"              
ess ls -r

echo "#########################################################"
echo "####Command 6: create a category with default options####"            
ess category add default 'climate'

echo "#####################################################################"
echo "####Command 7: create a category with a given dateregex formatter####"
ess category add ageregex 'dateformat/Dec-31-2015_age_gender.csv' --dateregex='[:%b:]-[:%d:]-[:%Y:]'

echo "#####################################################################"
echo "####Command 8: create a category with a given dateregex formatter####"
ess category add log 'dateformat/20140701000006am.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]'

echo "####################################################"
echo "####Command 9: create a category with preprocess####"                     
ess category add climate 'climate/01*.op' --dateregex='-[:%Y:]' --preprocess='logcnv  -f,+1,eok - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt -o,notitle -'

echo "########################################################"
echo "####Command 10: overwrite a category with preprocess####"                  
ess category add log 'dateformat/20140701000006am.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]' --preprocess='logcnv -f,eok,qui - -d ip:ip sep:" " s:rlog sep:" " s:rusr sep:" [" i,tim:time sep:"] \"" s,clf:req_line1 sep:" " s,clf:req_line2 sep:" " s,clf:req_line3 sep:"\" " i:res_status sep:" " i:res_size sep:" \"" s,clf:referrer sep:"\" \"" s,clf:user_agent sep:"\""' --overwrite

echo "############################################################################"
echo "####Command 11: modify category column specific, make all column strings####"
ess category change columnspec climate --alls

echo "##############################################"
echo "####Command 12: modify dateregex formatter####"
ess category change dateregex log '[:%Y:][:%m:][:%d:]'
