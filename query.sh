#!/bin/bash

ess purge asi-essentiapublic

ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

ess category add purchase 'diy_woodworking/purchase*.csv.gz' \
--columnspec='S:purchaseDate S:userID I:articleID f:price I:referrerID' --overwrite  
report 0 "added gz based category"

ess query "select * from purchase:2014-09-01:2014-09-02" 
report 0 "SELECT from 2 days of logs" 

ess query "select count(articleID) from purchase:2014-09-01:2014-09-01 group by userID" 
report 0 "COUNT from 1 days of logs" 

ess query "select * from purchase:2014-09-01:2014-09-01 order by price" 
report 0 "select with order" 

ess query "select count(distinct userID) from purchase:2014-09-01:2014-09-01"
report 0 "COUNT DISTINCT" 

ess query "select count(userID),articleID from purchase:2014-09-01:2014-09-01 group by articleID"
report 0 "GROUP BY"

ess query "select count(distinct articleID) from purchase:2014-09-01:2014-09-10 WHERE price > 5" 
report 0 "WHERE" 

ess query 'select count(distinct referrerID) from purchase:*:* WHERE PatCmp(userID,"66")' 
report 0 "WHERE"

