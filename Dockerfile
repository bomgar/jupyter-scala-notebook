FROM jupyter/minimal-notebook
MAINTAINER Patrick Haun <bomgar85@googlemail.com>

USER root

# Install Java.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \ 
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get update && \
    apt-get install -y oracle-java8-installer --no-install-recommends && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    rm -rf /var/cache/apt && \
    rm -rf /var/lib/apt/lists/*



# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD https://oss.sonatype.org/content/repositories/snapshots/com/github/alexarchambault/jupyter/jupyter-scala-cli_2.11.6/0.2.0-SNAPSHOT/jupyter-scala_2.11.6-0.2.0-SNAPSHOT.tar.xz /tmp/jupyter-scala.tar.xz
RUN tar -xf /tmp/jupyter-scala.tar.xz && \
    chown -R jovyan . && \
    sudo -u jovyan jupyter-scala*/bin/jupyter-scala && \
    rm /tmp/jupyter-scala.tar.xz

USER jovyan
