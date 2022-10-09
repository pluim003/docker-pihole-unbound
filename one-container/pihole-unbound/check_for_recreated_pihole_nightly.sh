#!/bin/bash

BASEDIR=$(dirname $0)
#date >>check_for_recreated_pihole_nightly.log
date

pihole_nightly_image=pihole/pihole:nightly
pihole_unbound_nightly_image=pluim003/pihole-unbound:nightly

docker pull "${pihole_nightly_image}" 
docker pull "${pihole_unbound_nightly_image}" 

created_pihole_nightly="$(docker inspect ${pihole_nightly_image}  | grep Created)"
created_pihole_unbound_nightly="$(docker inspect ${pihole_unbound_nightly_image}  | grep Created)"

echo Pihole-nightly ${created_pihole_nightly}
echo Pihole-unbound-nightly ${created_pihole_unbound_nightly}

if [[ "${created_pihole_nightly}" > "${created_pihole_unbound_nightly}" ]];
then echo "There is a new Pihole-nightly, recreating the Pihole-Unbound-nightly" 
	   sh $BASEDIR/build_and_push_arm_nightly.sh
fi

#date >>check_for_recreated_pihole_nightly.log
date

exit $?
