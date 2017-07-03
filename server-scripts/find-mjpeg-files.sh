#!/usr/bin/env bash

gen_outfile () {
    outfile="${1}"
    ffmpeg_cl=(-s "$2" -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p -c:a aac -b:a 240k -strict -2 "$outfile")
}

find "$1" -name '*.m4a' | while read line; do
  stream=$(ffprobe -v error -select_streams V:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$line")
  if [ "$stream" == 'h264' ]; then
    filepath=$( greadlink -f "$line" )
    # echo $filepath
    new=$( sed 's|.m4a|.fixed.m4a|g' <<< $filepath )
    ffmpeg -i "$filepath" -vn -acodec copy "$new" < /dev/null
    mkdir -p "/Volumes/Storage/SOURCE$(dirname "$filepath")"
    mv "$filepath" "/Volumes/Storage/SOURCE$filepath"
    mv "$new" "$filepath"
  fi
done
