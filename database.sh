#!/bin/sh

###examples on how to create database, import data into database####
###and manipulate, export data from database

####clear all previous daemons and server files#####
echo "##############################################################"
echo "command 1: clear all previous daemons and server files########"
ess server reset

echo "##############################################################"
echo "command 2: create a new database entry at port 10011##########"
ess create database climate --ports=10011

echo "##############################################################"
echo "command 3: create a new table entry to the active database####"
ess create table table1 s,pkey:artificial S:col_1 S:col_2 S:col_3 S:col_4 F:col_5 I:col_6 F:col_7 I:col_8 F:col_9 I:col_10 F:col_11 I:col_12 F:col_13 I:col_14 F:col_15 I:col_16 F:col_17 F:col_18 F:col_19 S:col_20 F:col_21 S:col_22 F:col_23 S:col_24 F:col_25 S:col_26

echo "##############################################################"
echo "command 4: upload server files to workers#####################"
ess server commit

echo "##############################################################"
echo "command 5: summary of server files############################"
ess server summary

echo "##############################################################"
echo "command 6: connect to a s3 datastore##########################"
ess select s3://asi-essentiapublic --credentials $ESS_AWS_DIR/demo_essentiaPublic.csv

echo "##############################################################"
echo "command 7: create a category##################################"
ess category add weatherdata 'climate/*' --dateregex='-[:%Y:]' --preprocess 'logcnv  -f,+1,eok - -d s,n=7,trm:stn s,n=7,trm:wban s,n=4,trm:year s,n=6,trm:moda s,n=7,trm:temp s,n=4,trm:Tobs s,n=7,trm:dewp s,n=4,trm:Dobs s,n=7,trm:slp s,n=4,trm:Sobs s,n=7,trm:stp s,n=4,trm:Pobs s,n=6,trm:visib s,n=4,trm:Vobs s,n=6,trm:wdsp s,n=4,trm:Wobs s,n=7,trm:mxspd s,n=7,trm:gust s,n=6,trm:max s,n=2,trm:xf s,n=6,trm:min s,n=2,trm:nf s,n=5,trm:prcp s,n=2,trm:pf s,n=7,trm:sndp s,n=6,trm:frshtt -o,notitle -' --columnspec 'S:col_1 S:col_2 S:col_3 S:col_4 F:col_5 I:col_6 F:col_7 I:col_8 F:col_9 I:col_10 F:col_11 I:col_12 F:col_13 I:col_14 F:col_15 I:col_16 F:col_17 F:col_18 F:col_19 S:col_20 F:col_21 S:col_22 F:col_23 S:col_24 F:col_25 S:col_26' --overwrite

echo "##############################################################"
echo "command 8: streaming category content to table1 in climate####"
ess stream weatherdata "*" "*" "aq_pp -f,eok - -d %cols -eval s:artificial '\"%FILE\"+ToS(\$RowNum)' -udb -imp climate:table1"

echo "##############################################################"
echo "command 9: export data to local disk##########################"
ess exec "aq_udb -exp climate:table1 -local" > climatedata.csv

echo "##############################################################"
echo "command 10: show first 5 lines of the csv file#################"
head -5 climatedata.csv

echo "##############################################################"
echo "command 11: stop server########################################"
ess udbd stop
