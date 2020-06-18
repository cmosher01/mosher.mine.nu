FROM ubuntu:devel

USER root
ENV HOME /root
WORKDIR $HOME

RUN df -m /

ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get update && \
    apt-get install -y openjdk-11-jdk-headless git webhook && \
    apt-get clean

RUN df -m /

RUN git clone https://github.com/cmosher01/Gedcom-Redact.git
RUN git clone https://github.com/cmosher01/Gedcom-Uid.git
RUN git clone https://github.com/cmosher01/Gedcom-Cull.git
RUN git clone https://github.com/cmosher01/Gedcom-Attach.git

RUN cp -Rv Gedcom-Redact/gradlew Gedcom-Redact/gradle ./

COPY settings.gradle ./
COPY build.gradle ./

RUN \
    ./gradlew build && \
    find . -name \*.deb | xargs dpkg -i && \
    rm -Rf build .gradle */build

COPY *.sh /usr/local/bin/
COPY webhook.json ./
ENTRYPOINT ["/usr/bin/webhook"]
CMD ["-verbose","-hooks","webhook.json"]
