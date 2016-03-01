######dump credentials to the write path######
echo "Please copy credential csv files to the following path"
credenPath=`pwd`/.aws
echo $credenPath
echo " "
echo "#######################################################"

#####essentia helps to bring data from differnt platform to one place"
####add s3 bucket to datastores###############
echo "command1: add in NASA NEX large Earth science data including climate projects and satellite images"
ess select s3://nasanex --credentials $credenPath/demo_essentiaPublic.csv

echo "command2: view NASA NEX data as if it is on a local drive"
ess ls

echo "command3: add Landsat 8 with continuous record of earth's surface from space"

echo "command4: view Landsat as if it is on a local drive"
ess ls

echo "command5: add NOAA Next Generation Weather Radar network of 160 h-d Doppler radar sites"
ess select s3://noaa-nexrad-level2 --credentials $credenPath/demo_essentiaPublic.csv                                                      

echo "command6: view noaa-nexrad data as if it is on a local drive"
ess ls

###select azure blob datastore#######

echo "command7: add an azure blob bucket to datastore"
ess select blob://indexdev --credentials $credenPath/cborys_azure.csv

echo "command8: view blob datastore"
ess ls

echo "command9: switch back to s3 datastore"
ess select nasanex   ##(equivalent to cd /path)

echo "command10: view NASA NEX data as if it is on a local drive"
ess ls


