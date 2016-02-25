#!/bin/bash
###a tutorial for s3 public data repository##################
###AuriQ Systems provides a read-only key for demo purpose###

echo "command 1: connecting to a working data repository"
ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

####list files in home (root) directory#####
echo "command 2: list files in home dir###"
ess ls

###list files in a subdir#############
echo "command 3: list files in a subdir"
ess ls dateformat

###list files in a archive###
echo "command 4: list files in a tar archive"
ess lsa dateformat/gsod.1940-01-01.tar.bz2

###using category to group files####
echo "command 5: define a working category"
ess category add climate 'dateformat/gsod.1940-01-01.tar.bz2' --dateregex='[:%Y:]-[:%m:]-[:%d:]' --preprocess='logcnv -f,+1,eok,qui - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt' --overwrite

###show summary of category#####
echo "command 6: show category summary"
ess summary climate

###SQL-query raw data#####
echo "query category with tarred bz2 files"
ess query 'select count(distinct stn) from climate:*:*'

###streaming first few lines######
echo "print out the first 10 lines of category"
ess stream climate 1940-01-01 '*' 'head -10'

###write to a csv file###########
echo "stream data to aq_pp for a csv output"
ess stream climate '*' '*' 'aq_pp -f,+1r,eok - -d %cols -o climate.csv'

###show first 5 lines of climate.csv'
echo "show the first 5 lines of output"
ess select local
ess cat /var/www/html/mydmp/aws/1/climate.csv --label local | head -5
