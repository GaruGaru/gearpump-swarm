#! /bin/sh -

CONFIGURATION=gearpump_2.11-0.8.4-incubating/conf/gear.conf

sed -i -e 's/{{MASTERS}}/'"$MASTERS"'/g' ${CONFIGURATION}

sed -i -e 's/{{HOSTNAME}}/'"$HOSTNAME"'/g' ${CONFIGURATION}

sed -i -e 's/{{WORKER_SLOTS}}/'"$WORKER_SLOTS"'/g' ${CONFIGURATION}

