#!/bin/bash

ess purge asi-essentiapublic

ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

ess category add purchase 'diy_woodworking/purchase*.csv.gz' \
--columnspec='S:purchaseDate S:userID I:articleID f:price I:referrerID' --overwrite  

ess query "select * from purchase:2014-09-01:2014-09-02" 

ess query "select count(articleID) from purchase:2014-09-01:2014-09-01 group by userID" 

ess query "select * from purchase:2014-09-01:2014-09-01 order by price" 
ess query "select count(distinct userID) from purchase:2014-09-01:2014-09-01"

ess query "select count(userID),articleID from purchase:2014-09-01:2014-09-01 group by articleID"

ess query "select count(distinct articleID) from purchase:2014-09-01:2014-09-10 WHERE price > 5" 

ess query 'select count(distinct referrerID) from purchase:*:* WHERE PatCmp(userID,"66")' 

