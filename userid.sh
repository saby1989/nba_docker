#!/bin/bash

#Display the UID and username of the user execurting the script
#Display if the user is root or not

#get the userid and username
USERNAME=$(id -n -u)
USERID=${UID}

#Display the USERID
echo "the current userid is ${USERID} and username is $USERNAME"

#running the python file
python3 /app/index.py

if [[ ${?} -eq 0 ]]
then
  echo  "the python code has completed sucessfully"
else
  echo "the python code has failed"
fi
