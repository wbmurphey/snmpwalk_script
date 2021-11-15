#! /bin/bash
# Pass a list of IP addresses as the first and only argument to this script.
# The script will validate them against the following two community strings:
# communitystring & communitystring2, and create verified and unverified output files.

now=$(date '+%F_%H:%M')
while read ip; do
  if snmpwalk -Oqv -t 1 -r 1 -v 2c -c communitystring ${ip} sysName.0;
    then hostname=$(snmpwalk -Oqv -t 1 -r 1 -v 2c -c communitystring ${ip} sysName.0);
    printf "${ip}, ${hostname}\n" >> /home/wmurphey/verified_devices/libre_verified_${1}_${now}.csv;
  elif snmpwalk -Oqv -t 1 -r 1 -v 2c -c communitystring2 ${ip} sysName.0;
    then hostname=$(snmpwalk -Oqv -t 1 -r 1 -v 2c -c communitystring2 ${ip} sysName.0);
    printf "${ip}, ${hostname}\n" >> /home/wmurphey/verified_devices/libre_verified_${1}_${now}.csv;
  else echo "${ip}" >> /home/wmurphey/unverified_devices/libre_unverified_${1}_${now}.csv;
  fi
done <$1
