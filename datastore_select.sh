####select local disk as datastore#####
echo "select local disk"
ess select local
ess ls /data
ess category add localcli 'data/climate'
ess summary localcli
####select s3 datastore###############
echo "select an s3 opendata bucket"
ess select s3://nasanex --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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
ess ls
###select azure blob datastore#######
echo "select an azure blob bucket"
ess select blob://indexdev --credentials cborys_azure.csv
ess ls
