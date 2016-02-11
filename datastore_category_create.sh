#!/bin/bash

## This script demos:
##1) how to choose a datastore - ess select
##2) how to view files/directories in the selected datastore - ess ls
##3) how to view a compressed file -- ess lsa
##4) how to create a category -- ess category add
##5) how to modify some category attributes -- ess category change
ess purge asi-essentiapublic
#example  1
########select a s3 bucket as datastore########
ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key ekIr5mhZHCbNNC29hW2MpzOX/oiBgJ3QOph3rxAG
echo "select s3 datastore"

#example  2
########list all files and directories in the parent directory######## 
ess ls

#example  3
########list files and directories in a given subdirectory########
ess ls climate

#example  4
########list files in all subdirectories recursively########
ess ls -r

#example 5
########create a category with default options except for pattern#####
ess category add default 'climate'
echo "create category 'default'"

#example 6 
########create a category with a given date formatter########
ess category add ageregex 'dateformat/Dec-31-2015_age_gender.csv' --dateregex='[:%b:]-[:%d:]-[:%Y:]'
echo "create category ageregex"

#example 7    
########create a category with another date formatter with am/pm#######
ess category add log 'dateformat/20140701000006am.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]'
echo "create category log"

#example 8      
########create a category with preprocess command########
ess category add climate 'climate/01*.op' --dateregex='-[:%Y:]' --preprocess='logcnv  -f,+1,eok - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt -o,notitle -'
echo "create category climate"

#example 9
########overwrite a category with preprocess command#########
ess category add log 'dateformat/20140701000006am.log' --dateregex='[:%Y:][:%m:][:%d:][:%H:][:%M:][:%S:][:%p:]' --preprocess='logcnv -f,eok,qui - -d ip:ip sep:" " s:rlog sep:" " s:rusr sep:" [" i,tim:time sep:"] \"" s,clf:req_line1 sep:" " s,clf:req_line2 sep:" " s,clf:req_line3 sep:"\" " i:res_status sep:" " i:res_size sep:" \"" s,clf:referrer sep:"\" \"" s,clf:user_agent sep:"\""' --overwrite
echo "overwrite category log"

#example 10
########modify category column specific########
ess category change columnspec climate --alls
echo "change category column specific"

#example 11
########modify date formatter########
ess category change dateregex log '[:%Y:][:%m:][:%d:]'
echo "change category date format"
