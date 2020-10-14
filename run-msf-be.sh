#!/bin/sh

echo ENVIRONMENT_NAME: $ENVIRONMENT_NAME

case $ENVIRONMENT_NAME in

  Development)
    export HOSTADDR=0.0.0.0
    export HOSTPORT=8001
    export PGENDPOINT=oisdevaurora-postgres.cluster-cvzk9rdnz9on.us-west-2.rds.amazonaws.com
    export PGPORT=5432
    export PGUSER=methanesourcefinder
    export PGPASSWORD=[PASSWORD]
    export S3BUCKET=methane
    export NUMSUBPROCS=2
  ;;

  UAT)
    export HOSTADDR=0.0.0.0
    export HOSTPORT=8001
    export PGENDPOINT=oisdevaurora-postgres.cluster-cvzk9rdnz9on.us-west-2.rds.amazonaws.com
    export PGPORT=5432
    export PGUSER=methanesourcefinder
    export PGPASSWORD=[PASSWORD]
    export S3BUCKET=methane
    export NUMSUBPROCS=4
  ;;

  Production)
    export HOSTADDR=0.0.0.0
    export HOSTPORT=8001
    export PGENDPOINT=oisdevaurora-postgres.cluster-cvzk9rdnz9on.us-west-2.rds.amazonaws.com
    export PGPORT=5432
    export PGUSER=methanesourcefinder
    export PGPASSWORD=[PASSWORD]
    export S3BUCKET=methane
    export NUMSUBPROCS=8
  ;;

  *)
  echo "Environenment not specified, please set $ENVIRONMENT_NAME to one of Development, UAT, or Production"
  exit
  ;;

esac

echo Config info:
echo Host: $HOSTADDR
echo Port: $HOSTPORT
echo PG Endpoint: $PGENDPOINT
echo PG Port: $PGPORT
echo PG User: $PGUSER
echo PG Password: ------
echo S3 Bucket: $S3BUCKET
echo Number of Subprocesses: $NUMSUBPROCS

echo Running: python -m msfbe.main --address=$HOSTADDR --port=$HOSTPORT --pgendpoint=$PGENDPOINT --pgport=$PGPORT --pguser=$PGUSER --pgpassword=$PGPASSWORD --s3bucket=$S3BUCKET --subprocesses=$NUMSUBPROCS

python -m msfbe.main --address=$HOSTADDR --port=$HOSTPORT --pgendpoint=$PGENDPOINT --pgport=$PGPORT --pguser=$PGUSER --pgpassword=$PGPASSWORD --s3bucket=$S3BUCKET --subprocesses=$NUMSUBPROCS
