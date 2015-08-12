FROM jenkins
USER root
RUN apt-get update && apt-get install -y bzip2 openjdk-7-jdk
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
