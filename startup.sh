#!/bin/bash

sed -i "s/<username>/$username/g" ~/cntlm.conf
sed -i "s/<domain>/$domain/g" ~/cntlm.conf
sed -i "s/<proxy>/$proxy/g" ~/cntlm.conf

CNTLM_PASS=$(echo ${password} | cntlm -u ${username} -d ${domain} -H | grep -v Password: | tr '\n' "\\n")
perl -i.bak -pe 's/<password>/'"$CNTLM_PASS"'/g' ~/cntlm.conf

cntlm -v -c ~/cntlm.conf & echo cntlm started
sudo redsocks -c ~/redsocks.conf & echo redsocks started

sleep infinitys
