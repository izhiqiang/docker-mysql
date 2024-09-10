#!/bin/bash

set -e
set -u
tags=("5.7" "8.0" "8.1" "8.2" "8.3" "8.4")
# 循环遍历数组中的每个元素
for tag in "${tags[@]}"
do
    echo "Downloading mysql:$tag"
    docker pull mysql:$tag
    echo "rename mysql:$tag -> hkccr.ccs.tencentyun.com/buildx/hub:mysql-$tag"
    docker tag mysql:$tag hkccr.ccs.tencentyun.com/buildx/hub:mysql-$tag
    docker push hkccr.ccs.tencentyun.com/buildx/hub:mysql-$tag
done
