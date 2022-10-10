#!/bin/bash

BASEDIR=$(dirname $0)
#date >>check_for_recreated_pihole_latest.log
date

pihole_latest_image=pihole/pihole:latest
pihole_unbound_latest_image=pluim003/pihole-unbound:latest

docker pull "${pihole_latest_image}" 
docker pull "${pihole_unbound_latest_image}" 

created_pihole_latest="$(docker inspect ${pihole_latest_image}  | grep Created)"
created_pihole_unbound_latest="$(docker inspect ${pihole_unbound_latest_image}  | grep Created)"

echo Pihole-latest ${created_pihole_latest}
echo Pihole-unbound-latest ${created_pihole_unbound_latest}

if [[ "${created_pihole_latest}" > "${created_pihole_unbound_latest}" ]];
then echo "There is a new Pihole-latest, recreating the Pihole-Unbound-latest" 
	   sh $BASEDIR/build_and_push_latest.sh
fi

#date >>check_for_recreated_pihole_latest.log
date

exit $?
