#!/bin/bash

max_min_size=15
docker images | awk 'NR>1 {print $0}' | while read line; do
    # echo $line
    id_img=$(echo $line | awk '{print $3}')

    # if older then a month
    is_month=$(echo $line | grep 'month')
    if [ ! -z "$is_month" ]; then 
        echo $id_img
        docker rmi -f $id_img
        continue
    fi

    # remove older then 4 mins
    num_min=$(echo $line | grep "min" | awk '{print $15}')
    if [ ! -z "$num_min" ] && [ $num_min -ge $max_min_size ]; then 
        echo $id_img
        docker rmi -f $id_img
    fi
done