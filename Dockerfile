FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# تثبيت الأساسيات
RUN apt-get update && apt-get install -y \
  curl wget gnupg ca-certificates sudo nano git unzip redis-server \
  software-properties-common

# تثبيت Docker داخل الحاوية (لـ MinIO)
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# تثبيت CouchDB
RUN curl https://couchdb.apache.org/repo/bintray-pubkey.asc | apt-key add - && \
    add-apt-repository "deb https://apache.jfrog.io/artifactory/couchdb-deb/ focal main" && \
    apt-get update && apt-get install -y couchdb

# إعداد Minio
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x minio && mv minio /usr/local/bin/

# Budibase Apps (الصورة الرسمية)
RUN mkdir -p /opt/budibase
WORKDIR /opt/budibase
RUN curl -L https://github.com/Budibase/budibase/releases/latest/download/self-hosted.zip -o budibase.zip && \
    unzip budibase.zip && rm budibase.zip

# نسخ سكريبت البدء
COPY start.sh /start.sh
RUN chmod +x /start.sh

# فتح البورت الأساسي
EXPOSE 80

CMD ["/start.sh"]
