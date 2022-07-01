#!/bin/sh
ProjectName=ma35d1_2

sudo docker ps -a | grep ${ProjectName}_$(id -nu)>/dev/null;
if [ $? -ne 0 ]
then
	echo "Container ${ProjectName}_$(id -nu) is not existed!!!"
else
	sudo docker start ${ProjectName}_$(id -nu)
	sudo docker exec -u $(id -nu) -it ${ProjectName}_$(id -nu) bash
fi
