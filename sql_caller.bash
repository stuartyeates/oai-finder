#!/bin/bash

DB=./database

SQLCREATE="CREATE TABLE url ( id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT ); \
           CREATE TABLE links (  id INTEGER PRIMARY KEY AUTOINCREMENT, from1 INTEGER REFERENCES url (id), to1 INTEGER REFERENCES url (id)); \
           CREATE TABLE rule ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT); \
           CREATE TABLE rule_use  ( id INTEGER PRIMARY KEY AUTOINCREMENT,  rule INTEGER REFERENCES rule (id), option_1 TEXT, option_2 TEXT, option_3 TEXT, option_4 TEXT); \
           CREATE TABLE url_found (  id INTEGER PRIMARY KEY AUTOINCREMENT, rule_use INTEGER REFERENCES rule_use (id), url INTEGER REFERENCES url (id));"


rm ${DB}

echo ${SQLCREATE} |sqlite3 ${DB}

sqlite3 ${DB} "INSERT INTO url (url) VALUES ('https://www.openarchives.org/Register/BrowseSites');";
sqlite3 ${DB} "SELECT url FROM url;";


URL=`sqlite3 ${DB} "SELECT url FROM url WHERE id = '1';";`
TMPFILE=./tmp_file





