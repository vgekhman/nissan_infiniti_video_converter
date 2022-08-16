#!/bin/sh


LOCAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FFMPEG=$LOCAL_DIR/ffmpeg 
DIRECTORY=$LOCAL_DIR/converts
FORMAT="mp4"

#usage ()
#{
#  echo 'Usage : ./convert -f <mp4;m4v;avi> '
#  exit
#}			

#if [ "$#" -ne 13 ]
#then
#  usage
#fi

while test $# -gt 0; do
        case "$1" in
                -f|--format)
					shift
					FORMAT=$1
					echo "Format specified:" + $1 
					;;
				*)
					break
					;;
		esac
done

if [ ! -d "$DIRECTORY" ]; then
  mkdir "$DIRECTORY"
fi

for i in *.$FORMAT ; do
	i = ${i// /_}
	filename=$(basename "$i")
	filename="${filename%.*}"
  	echo $filename; 
    $FFMPEG -i "$i" -y -threads 2 -vtag DIVX -f avi -vcodec mpeg4 -b:v 1071000 -aspect 16:9 -s 720x480 -r ntsc-film -g 240 -qmin 2 -qmax 9 -acodec mp3 -ab 128000 -ar 48000 -ac 2 -benchmark "$DIRECTORY/$filename.avi"
    sleep 60
done
