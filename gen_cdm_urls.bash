#!/bin/bash


DIR=./cache-cdm/

mkdir ${DIR}


for i in {1..50000}
do
    wget --force-directories --directory-prefix=${DIR} https://cdm${i}.contentdm.oclc.org/ &
    sleep 1
done
