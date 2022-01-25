FROM ubuntu:20.04

RUN apt-get update && \
    apt-get -y install \
    apt-transport-https \
    wget \
    software-properties-common

#install azcopy
RUN wget https://aka.ms/downloadazcopy-v10-linux && \
    tar -xvf downloadazcopy-v10-linux && \
    cp ./azcopy_linux_amd64_*/azcopy /usr/bin/

#install mongo cli tools
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
    apt-get update && apt-get install -y mongodb-org-tools

WORKDIR /tmp

COPY backup_mongo.sh .
RUN chmod a+x backup_mongo.sh
ENTRYPOINT [ "./backup_mongo.sh" ]
