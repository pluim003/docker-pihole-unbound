#!/bin/bash

BASEDIR=$(dirname $0)
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
           pihole_docker_tag="$(docker inspect ${pihole_latest_image}  | grep PIHOLE_DOCKER_TAG)"
	   pihole_docker_tag=$(pihole_docker_tag::-2)
	   pihole_docker_tag=`echo ${pihole_docker_tag}  | awk '{print substr($0, 20)}'`
	   echo ${pihole_docker_tag}
	   sh $BASEDIR/build_and_push_latest.sh $(pihole_docker_tag) 
fi

date

exit $?
