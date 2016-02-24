#####essentia helps to bring data from differnt platform to one place"
####add s3 bucket to datastores###############
echo "command1: add in NASA NEX large Earth science data including climate projects and satellite images"
ess select s3://nasanex --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "command2: view NASA NEX data as if it is on a local drive"
ess ls

echo "command3: add Landsat 8 with continuous record of earth's surface from space"
ess select s3://landsat-pds --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "command4: view Landsat as if it is on a local drive"
ess ls

echo "command5: add NOAA Next Generation Weather Radar network of 160 h-d Doppler radar sites"
ess select s3://noaa-nexrad-level2 --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "command6: view noaa-nexrad data as if it is on a local drive"
ess ls

###select azure blob datastore#######

echo "command7: add an azure blob bucket to datastore"
ess select blob://indexdev --credentials cborys_azure.csv

echo "command8: view blob datastore"
ess ls

echo "command9: switch back to s3 datastore"
ess select nasanex   ##(equivalent to cd /path)

echo "command10: view NASA NEX data as if it is on a local drive"
ess ls


