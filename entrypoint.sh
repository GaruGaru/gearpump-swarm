#!/usr/bin/bash

sed -i -e 's/{{MASTERS}}/'"$MASTERS"'/g' gearpump_2.11-0.8.4-incubating/conf/gear.conf

sed -i -e 's/{{HOSTNAME}}/'"$HOSTNAME"'/g' gearpump_2.11-0.8.4-incubating/conf/gear.conf

sed -i -e 's/{{WORKER_SLOTS}}/'"$WORKER_SLOTS"'/g' gearpump_2.11-0.8.4-incubating/conf/gear.conf

