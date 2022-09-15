#!/usr/bin/env bash

# 需要在deloy2 目录下运行本文件

export docker_image_name=litemall_img_2
export docker_container_name=litemall_api_2

cd ../..
mvn clean install
mvn package

cd deploy2/litemall_api
cp -f ../../litemall-all/target/litemall-all-*-exec.jar ./litemall.jar

# 生成新的后端 docker images 
docker stop $docker_container_name
docker rm $docker_container_name
docker rmi $docker_image_name

docker build -t $docker_image_name .

docker run -d --name $docker_container_name -p 8080:8080 -p 8081:8081 --link mysql57:db \
  -e mysql_host=db -e mysql_port=3306 -e mysql_user=litemall -e mysql_pwd=litemall123456 \
 $docker_image_name

