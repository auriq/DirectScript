#!/bin/bash

######First, please dump credentials to the right path######
echo "Please copy credential csv files to the following path"
credenPath=`pwd`/.aws
echo $credenPath
echo " "
echo "#######################################################"

echo "####Command 1: select a s3 datastore####"
ess select s3://asi-essentiapublic --credentials $credenPath/demo_essentiaPublic.csv

echo "####################################"
echo "####Command 2: create a category####"
ess category add log 'dateformat/2014*' --dateregex=[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]* --preprocess='logcnv -f,eok,qui - -d ip:ip sep:" " s:rlog sep:" " s:rusr sep:" [" i,tim:time sep:"] \"" s,clf:req_line1 sep:" " s,clf:req_line2 sep:" " s,clf:req_line3 sep:"\" " i:res_status sep:" " i:res_size sep:" \"" s,clf:referrer sep:"\" \"" s,clf:user_agent sep:"\""' --overwrite

echo "########################################"
echo "####Command 3: show category summary####"
ess summary log      

echo "########################################"
echo "####Command 4: show cat files###########"
ess ls --cat=log      

echo "########################################"
echo "####Command 4: stream data to stdout####"
ess stream log '*' '*'

echo "##########################################"
echo "####Command 5: stream data count lines####"
ess stream log 2014-07-01 '*' 'wc -l'

echo "################################################################################################"
echo "####Command 6: stream data to csv file,saved in UI home directory: /var/www/html/mydmp/aws/1####"
ess stream log '*' '*' 'aq_pp -f,+1r,eok - -d %cols -o log.csv'


