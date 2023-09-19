#!/bin/zsh

if [[ -d "./example-process-view" ]]; then
  echo "example-process-view directory exists, continuing..." 
  echo "removing old existing log files..."
  rm ./example-process-view/* > /dev/null
else 
  mkdir ./example-process-view
  echo "Created example-process-view directory."
fi
last_num=0
info_regex='T=([0-9]+) Scheduled: T([0-9]+) Ready: (T[0-9]+(, T[0-9]+)*)?'
./gradlew run | while IFS= read -r line; do
  echo $line 
  if [[ $line =~ $info_regex ]]; then
    #echo $match
    filename="T${match[2]}-proc.log"
    echo "$filename"
    if [ ! -e ./example-process-view/$filename ]; then
      touch "./example-process-view/$filename"
    fi
    echo "work" >> ./example-process-view/$filename
  fi
done 

