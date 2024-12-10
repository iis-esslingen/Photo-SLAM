#!/bin/bash

dates=("2023-08-18" "2023-09-15" "2024-01-13" "2024-04-11" "2024-05-29_1" "2024-05-29_2" "2024-05-29_3" "2024-05-29_4")

for date in "${dates[@]}"; do
    echo "Processing date: $date"

    trials=("0" "1" "2" "3" "4")

    for trial in "${trials[@]}"; do
        echo "  Trial: $trial"

        ../bin/rover_mono \
            ../ORB-SLAM3/Vocabulary/ORBvoc.txt \
            ../cfg/ORB_SLAM3/Monocular/ROVER/d435i.yaml \
            ../cfg/gaussian_mapper/Monocular/ROVER/rover_mono.yaml \
            /workspace/mounted_directory/media/$date/d435i \
            ../results/mono/$date/$trial \
            no_viewer

        ../bin/rover_rgbd \
            ../ORB-SLAM3/Vocabulary/ORBvoc.txt \
            ../cfg/ORB_SLAM3/RGB-D/ROVER/d435i.yaml \
            ../cfg/gaussian_mapper/RGB-D/ROVER/rover_rgbd.yaml \
            /workspace/mounted_directory/media/$date/d435i \
            /workspace/mounted_directory/media/$date/d435i/associations.txt \
            ../results/rgbd/$date/$trial \
            no_viewer
    done
done

echo "All dates processed."
