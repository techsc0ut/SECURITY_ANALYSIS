# This script will filter out the valid reachable domains from the list of domains
#!/bin/bash

filename='paytm_subd.txt'
for hstnm in $(cat file1.txt)
do
if ( dig @8.8.8.8 -t A "$hstnm" | grep -q 'NXDOMAIN' ) || ( dig @8.8.8.8 -t A "$hstnm" | grep -q 'SERVFAIL' ) && ( dig @8.8.8.8 -t CNAME "$hstnm" +short >/dev/null )
then
echo -n -e "\e[92mNXDOMAIN: \e[0m${hstnm} "
echo -n -e "\e[93mCNAME: \e[0m"; dig @8.8.8.8 -t CNAME "$hstnm" +short
echo
else
echo "${hstnm}" >> $filename
fi
done
