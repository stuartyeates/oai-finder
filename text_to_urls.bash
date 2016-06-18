#!/bin/bash


tr ' <>()"\000\r\n' '\012' | tr " '" '\012' | grep '^\(https:\|http:\)//[-A-Z0-9a-z]*.[-A-Z0-9a-z.]*/' 
