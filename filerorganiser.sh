#!/bin/bash
# Author: SJ
# Date Created: 6 June 2026
# Date Modified: 6 June 2026

# Description
# Organizes files within a specified directory into categorized subfolders
# based on their file extensions. Supported categories include images,
# documents, spreadsheets, scripts, archives, presentations, audio, and
# video files. Any files that do not match the predefined categories are
# moved to an "anyelse" folder. The target directory can be provided using
# the -f option or entered interactively when the script is executed.
path=''

while getopts "f:" opt;do
    case "$opt" in 
        f) path="${OPTARG}";;
        \?) echo "Invalid argument!" 
            exit 1;;
    esac
done

if [[ -z "$path" ]];then
    read -r -p "Enter the path of folder you want to organise" path
fi

if [[ ! -d "$path" ]];then
    echo "Path not found!"; exit 1
fi

# need to find files based on the order i want to
# .jpg, .jpeg, .png - images
# .doc, .docx, .txt, .pdf - documents doc|docx|txt|pdf
# .xls, .xlsx, .csv - spreadsheets xls|xlsx|csv
# sh - scripts sh
# .zip, .tar, .tar.gz, .tar.bz2 - archives zip|tar.gz|tar.bz2|tar
# .ppt, .pptx - presentations ppt|pptx
# .mp3 - audio mp3
# .mp4 - video mp4
# Anything else - to anyelse folder
readarray -t images < <( find "$path" -type f -regextype egrep -iregex ".*\.(jpg|jpeg|png)$" )
readarray -t documents < <( find "$path" -type f -regextype egrep -iregex ".*\.(doc|docx|txt|pdf)$" )
readarray -t spreadsheets < <( find "$path" -type f -regextype egrep -iregex ".*\.(xls|xlsx|csv)$" )
readarray -t scripts < <( find "$path" -type f -regextype egrep -iregex ".*\.sh$" )
readarray -t archives < <( find "$path" -type f -regextype egrep -iregex ".*\.(zip|tar\.gz|tar\.bz2|tar)$" )
readarray -t presentations < <( find "$path" -type f -regextype egrep -iregex ".*\.(ppt|pptx)$" )
readarray -t audio < <( find "$path" -type f -regextype egrep -iregex ".*\.mp3$" )
readarray -t video < <( find "$path" -type f -regextype egrep -iregex ".*\.mp4$" )
readarray -t anyelse < <( find "$path" -type f -regextype egrep -not -iregex ".*\.(jpg|jpeg|png|doc|docx|txt|pdf|xls|xlsx|csv|sh|zip|tar\.gz|tar\.bz2|tar|ppt|pptx|mp3|mp4)$" )

for folder in "images" "documents" "spreadsheets" "scripts" "archives" "presentations" "audio" "video" "anyelse"; do
    declare -n files="$folder"
    nofiles="${#files[@]}"
    if [[ "${nofiles}" -eq 0 ]]; then
        continue 
    fi

    if [[ ! -d "${path}/${folder}" ]];then
        mkdir "${path}/${folder}"
    fi

    for file in "${files[@]}";do
        echo "Moving the file ${file} to folder ${folder}"
        mv -n "${file}" "${path}/${folder}/"
    done
done
exit 0 