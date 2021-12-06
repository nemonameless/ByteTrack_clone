#!/bin/bash

# if MOT17 data not unziped, then download, unzip and lastly remove zip MOT17 data
if [[ ! -d datasets/mot/train ]] && [[ ! -d datasets/mot/test ]]
then
	# download data
	wget -nc https://motchallenge.net/data/MOT17.zip -O MOT17.zip
	# unzip
    unzip -q MOT17.zip -d datasets/
    # rename folder
    !mv datasets/MOT17 datasets/mot
    # remove zip
    !rm -r MOT17.zip
fi

for i in MOT17-02-FRCNN MOT17-04-FRCNN MOT17-05-FRCNN MOT17-09-FRCNN MOT17-10-FRCNN MOT17-11-FRCNN MOT17-13-FRCNN
	(
		# run inference on sequence frames
		python3 tools/demo_track_yolov5.py --path ./datasets/mot/train/$i/img1 image -f exps/example/mot/yolox_x_mot17_half.py -c pretrained/bytetrack_x_mot17.pth.tar --fp16 --fuse --save_result --save_name $i
	)
done