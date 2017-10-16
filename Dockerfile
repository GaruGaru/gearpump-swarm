FROM openjdk:8-jdk-alpine

ENV WORKER_SLOTS=1000
ENV MASTERS=["127.0.0.1:3000"]
ENV HOSTNAME=localhost 

RUN apk update
RUN apk add curl 

RUN curl --location --retry 3 --insecure https://dist.apache.org/repos/dist/release/incubator/gearpump/0.8.4-incubating/gearpump_2.11-0.8.4-incubating-bin.tgz -o gearpump.tgz

RUN tar -xvzf gearpump.tgz

COPY entrypoint.sh  gearpump_2.11-0.8.4-incubating/
RUN chmod +x entrypoint.sh

COPY gear.conf gearpump_2.11-0.8.4-incubating/conf/

WORKDIR gearpump_2.11-0.8.4-incubating

ENTRYPOINT ./entrypoint.sh

CMD tail -f /dev/null