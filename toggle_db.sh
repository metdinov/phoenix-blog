#!/bin/bash

if pg_ctl -D /usr/local/var/postgres status; then
	echo Stopping Postgres db
	pg_ctl -D /usr/local/var/postgres stop
else
	echo Starting Postgres db
	pg_ctl -D /usr/local/var/postgres start
fi
