#!/usr/bin/env bash

STATUS_START_STR='{"text":"Connected","class":"connected","alt":"connected"}'
STATUS_STOP_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'

function status_service() {
  systemctl is-active "$1" >/dev/null 2>&1
  return $?
}

function toggle_service() {
	SERVICE_NAME=$1
  status_service "$SERVICE_NAME" && \
	  pkexec systemctl stop $SERVICE_NAME || \
	  pkexec systemctl start $SERVICE_NAME
}

case $1 in
  -s )
    status_service $2 && echo $STATUS_START_STR || echo $STATUS_STOP_STR
    ;;
  -t )
    toggle_service $2
    ;;
esac
