#!/usr/bin/env bash

source_folder=/Users/mshick/test
destination_folder=/Users/mshick/dest

files=( $(/usr/local/bin/watchman since "${source_folder}" n:movies -- -I "**/*.mkv" | /usr/local/bin/jq -r '.files | map(select (.new == true)) | map(.name) | join(" ")') )

echo  "[$(date)] Checked for new movies in ${source_folder}"

for file in "${files[@]}"; do
    src="${source_folder}/${file}"
    dst="${destination_folder}/${file}"

    echo "[$(date)] Copying file ${src} to ${dst}"

    # cp "${source_folder}/${file}" "${destination_folder}/${file}"
done
