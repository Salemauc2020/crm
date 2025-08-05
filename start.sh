#!/bin/bash

# 1. تشغيل CouchDB
echo "Starting CouchDB..."
couchdb -b

# 2. تشغيل Redis
echo "Starting Redis..."
redis-server &

# 3. تشغيل MinIO
echo "Starting MinIO..."
mkdir -p /data/minio
export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin
nohup minio server /data/minio --console-address ":9001" > /dev/null 2>&1 &

# 4. إعداد متغيرات Budibase
export COUCHDB_URL=http://admin:admin@127.0.0.1:5984
export REDIS_HOST=127.0.0.1
export REDIS_PORT=6379
export MINIO_ACCESS_KEY=minioadmin
export MINIO_SECRET_KEY=minioadmin
export INTERNAL_API_KEY=budibase123
export PORT=80

# 5. تشغيل Budibase Apps
echo "Starting Budibase..."
cd /opt/budibase
./start-production.sh
