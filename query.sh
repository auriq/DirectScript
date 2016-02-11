#!/bin/bash

echo "####Command 1: select a s3 datastore####"
ess select s3://asi-essentiapublic --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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

echo "####################################"
echo "####Command 2: create a category####"
ess category add purchase 'diy_woodworking/purchase*.csv.gz' \
--columnspec='S:purchaseDate S:userID I:articleID f:price I:referrerID' --overwrite  

echo "########################################"
echo "####Command 3: show category summary####"
ess summary purchase 

echo "###################################################"
echo "####Command 4: sql-like query select all column####"
ess query "select * from purchase:2014-09-01:2014-09-02" 

echo "##########################################################"               
echo "####Command 5: sql-like query count by group of userID####"               
ess query "select count(articleID) from purchase:2014-09-01:2014-09-01 group by userID" 

echo "################################################"               
echo "####Command 6: sql-like query order by price####"               
ess query "select * from purchase:*:2014-09-02 order by price" 

echo "####################################################"               
echo "####Command 7: sql-like query count unique userID###"               
ess query "select count(distinct userID) from purchase:2014-09-01:*"

echo "################################################"               
echo "####Command 8: sql-like query count by group####"               
ess query "select count(userID),articleID from purchase:2014-09-01:2014-09-01 group by articleID"

echo "############################################################################"      
echo "####Command 9: sql-like query count with where-clause for numeric values####"      
ess query "select count(distinct articleID) from purchase:2014-09-01:2014-09-10 WHERE price > 5" 

echo "######################################################################"      
echo "####Command 10: sql-like query count with where-clause for strings####"      
ess query 'select count(distinct referrerID) from purchase:*:* WHERE PatCmp(userID,"66")' 

