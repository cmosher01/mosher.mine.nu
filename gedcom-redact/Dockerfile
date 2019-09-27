FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install openjdk-11-jdk -y

RUN apt-get install -y git webhook

USER root
ENV HOME /root
WORKDIR $HOME

COPY settings.gradle ./
COPY build.gradle ./

RUN git clone https://github.com/cmosher01/Gedcom-Redact.git

RUN Gedcom-Redact/gradlew gedcom-redact:build
RUN Gedcom-Redact/gradlew gedcom-redact:assemble
RUN dpkg -i Gedcom-Redact/build/distributions/*.deb
RUN gedcom-redact --help

COPY create-redacted-gedcom-mirror.sh /usr/local/bin
COPY webhook.json ./
ENTRYPOINT ["/usr/bin/webhook"]
CMD ["-verbose","-hooks","webhook.json"]
