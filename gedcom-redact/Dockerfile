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

RUN git clone https://github.com/cmosher01/Gedcom-Uid.git
RUN Gedcom-Uid/gradlew gedcom-uid:build
RUN Gedcom-Uid/gradlew gedcom-uid:assemble
RUN dpkg -i Gedcom-Uid/build/distributions/*.deb

RUN git clone https://github.com/cmosher01/Gedcom-Cull.git
RUN Gedcom-Cull/gradlew gedcom-cull:build
RUN Gedcom-Cull/gradlew gedcom-cull:assemble
RUN dpkg -i Gedcom-Cull/build/distributions/*.deb

RUN git clone https://github.com/cmosher01/Gedcom-Attach.git
RUN Gedcom-Attach/gradlew gedcom-attach:build
RUN Gedcom-Attach/gradlew gedcom-attach:assemble
RUN dpkg -i Gedcom-Attach/build/distributions/*.deb

COPY *.sh /usr/local/bin/
COPY webhook.json ./
ENTRYPOINT ["/usr/bin/webhook"]
CMD ["-verbose","-hooks","webhook.json"]
