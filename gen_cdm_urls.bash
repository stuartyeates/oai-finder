#!/bin/bash


DIR=./cache-cdm/

mkdir ${DIR}


for i in {1..50000}
do
    echo wget --force-directories --directory-prefix=${DIR} https://cdm${i}.contentdm.oclc.org/
    sleep 1
done
