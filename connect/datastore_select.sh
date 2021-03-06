echo "#######################################################"

#####essentia helps to bring data from differnt platform to one place"
####add s3 bucket to datastores###############
echo "command1: add in NASA NEX large Earth science data including climate projects and satellite images"
ess select s3://nasanex 

echo "command2: view NASA NEX data as if it is on a local drive"
ess ls

echo "command3: add Landsat 8 with continuous record of earth's surface from space"

echo "command4: view Landsat as if it is on a local drive"
ess ls

echo "command5: add NOAA Next Generation Weather Radar network of 160 h-d Doppler radar sites"
ess select s3://noaa-nexrad-level2 

echo "command6: view noaa-nexrad data as if it is on a local drive"
ess ls

echo "command7: switch back to nasanex"         
ess select nasanex   ##(equivalent to cd /path)

echo "command8: view NASA NEX data as if it is on a local drive"
ess ls

echo "command9: connect to auriq opendata"
ess select s3://asi-essentiapublic
