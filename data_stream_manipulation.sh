#!/bin/bash

echo "####Command 1: select a s3 datastore####"
ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "####################################"
echo "####Command 2: create a category####"
ess category add log 'dateformat/20140701000006am.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]' --preprocess='logcnv -f,eok,qui - -d ip:ip sep:" " s:rlog sep:" " s:rusr sep:" [" i,tim:time sep:"] \"" s,clf:req_line1 sep:" " s,clf:req_line2 sep:" " s,clf:req_line3 sep:"\" " i:res_status sep:" " i:res_size sep:" \"" s,clf:referrer sep:"\" \"" s,clf:user_agent sep:"\""' --overwrite

echo "########################################"
echo "####Command 3: show category summary####"
ess summary log      

echo "########################################"
echo "####Command 4: stream data to stdout####"
ess stream log '*' '*'

echo "##########################################"
echo "####Command 4: stream data to csv file####"
ess stream log '*' '*' 'aq_pp -f,+1r,eok - -d %cols -o log.csv'
