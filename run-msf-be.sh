#!/bin/sh


HOSTADDR=${1:-0.0.0.0}
HOSTPORT=${2:-9090}
PGENDPOINT=${3:-methanesourcefinder.crlexf3r4fgu.us-gov-west-1.rds.amazonaws.com}
PGPORT=${4:-5432}
PGUSER=${5:-methane}
PGPASSWORD=${6:-foo}
S3BUCKET=${7:-methane}
NUMSUBPROCS=${8:-0}

echo Host: $HOSTADDR
echo Port: $HOSTPORT
echo PG Endpoint: $PGENDPOINT
echo PG Port: $PGPORT
echo PG User: $PGUSER
echo PG Password: ------
echo S3 Bucket: $S3BUCKET
echo Number of Subprocesses: $NUMSUBPROCS

python -m msfbe.main --address=$HOSTADDR --port=$HOSTPORT --pgendpoint=$PGENDPOINT --pgport=$PGPORT --pguser=$PGUSER --pgpassword=$PGPASSWORD --s3bucket=$S3BUCKET --subprocesses=$NUMSUBPROCS
