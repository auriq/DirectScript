####select local disk as datastore#####
ess select local
ess ls
####select s3 datastore###############
ess select s3://nasanex --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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
ess ls
###select azure blob datastore#######
ess select blob://indexdev --credentials cborys_azure.csv
ess ls
