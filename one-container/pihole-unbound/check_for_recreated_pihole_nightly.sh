#!/bin/bash

date >>check_for_recreated_pihole_nightly.log

pihole_nightly_image=pihole/pihole:nightly
pihole_unbound_nightly_image=pluim003/pihole-unbound:nightly

docker pull "${pihole_nightly_image}" 
docker pull "${pihole_unbound_nightly_image}" 

created_pihole_nightly="$(docker inspect ${pihole_nightly_image}  | grep Created)"
created_pihole_unbound_nightly="$(docker inspect ${pihole_unbound_nightly_image}  | grep Created)"

echo Pihole-nightly ${created_pihole_nightly} >>check_for_recreated_pihole_nightly.log
echo Pihole-unbound-nightly ${created_pihole_unbound_nightly} >>check_for_recreated_pihole_nightly.log

if [[ "${created_pihole_nightly}" > "${created_pihole_unbound_nightly}" ]];
then echo "There is a new Pihole-nightly, recreating the Pihole-Unbound-nightly" >>check_for_recreated_pihole_nightly.log
	   sh $PWD/build_and_push_nightly.sh
fi

date >>check_for_recreated_pihole_nightly.log

exit $?
