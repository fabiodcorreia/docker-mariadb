#!/bin/bash

# check server
STATUS=`mysql -h localhost -uroot -p123123 -e "STATUS" | wc -l`
if [ $STATUS == 0 ]; then
  echo "**** No Database status ****"
  exit 1
fi

# check databases
DATABASES=`mysql -h localhost -uroot -p123123 -e "SHOW DATABASES" | grep -v Database`

function checkDB {
  DB=`echo $DATABASES | grep $1 | wc -l`
  if [ $DB == 0 ]; then
    echo "**** Database $1 not found ****"
    exit 1
  fi
}


checkDB mysql
checkDB information_schema
checkDB performance_schema
checkDB dummydb

# check users
USERS=`mysql -h localhost -uroot -p123123 -e "SELECT user FROM mysql.user" | grep -v User`

function checkUser {
  DB=`echo $USERS | grep $1 | wc -l`
  if [ $DB == 0 ]; then
    echo "**** User $1 not found ****"
    exit 1
  fi
}

checkUser root
checkUser mariadb.sys
checkUser dummyuser
