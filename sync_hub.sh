#!/bin/bash

set -e
set -u
tags=("5.7" "8.0" "8.1" "8.2")
# 循环遍历数组中的每个元素
for tag in "${tags[@]}"
do
    echo "Downloading mysql:$tag"
    docker pull mysql:$tag
    echo "rename mysql:$tag -> registry.cn-hongkong.aliyuncs.com/gfhub/mysql:$tag"
    docker tag mysql:$tag registry.cn-hongkong.aliyuncs.com/gfhub/mysql:$tag
    docker push registry.cn-hongkong.aliyuncs.com/gfhub/mysql:$tag
done