#!/bin/sh

###examples on how to create database, import data into database####
###and manipulate, export data from database

ess server reset

ess create database climate --ports=10011

ess create table table1 s,pkey:artificial S:col_1 S:col_2 S:col_3 S:col_4 F:col_5 I:col_6 F:col_7 I:col_8 F:col_9 I:col_10 F:col_11 I:col_12 F:col_13 I:col_14 F:col_15 I:col_16 F:col_17 F:col_18 F:col_19 S:col_20 F:col_21 S:col_22 F:col_23 S:col_24 F:col_25 S:col_26

ess server commit

ess server summary

ess select s3://asi-essentiapublic --credentials $credenPath/demo_essentiaPublic.csv

ess category add weatherdata 'climate/*' --dateregex '-[:%Y:]' --preprocess 'logcnv  -f,+1,eok - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt -o,notitle -' --columnspec 'S:col_1 S:col_2 S:col_3 S:col_4 F:col_5 I:col_6 F:col_7 I:col_8 F:col_9 I:col_10 F:col_11 I:col_12 F:col_13 I:col_14 F:col_15 I:col_16 F:col_17 F:col_18 F:col_19 S:col_20 F:col_21 S:col_22 F:col_23 S:col_24 F:col_25 S:col_26'

ess stream $line "*" "*" "aq_pp -f,eok - -d %cols -eval s:artificial '\"%FILE\"+ToS(\$RowNum)' -udb -imp climate:table1"

ess exec "aq_udb -exp climate:table1 -local" >> climatedata.csv

ess cat `pwd`/climatedata.csv | wc -l

ess udbd stop


