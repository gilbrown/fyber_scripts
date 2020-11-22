FROM jenkins/jenkins:lts
USER root

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli


RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod 777 /usr/local/bin/docker-compose

COPY jcasc/casc.yaml /usr/share/jenkins/ref/casc.yaml.override
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

USER jenkins
COPY plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#RUN jenkins-plugin-cli --plugins maven-plugin:3.8 maven-invoker-plugin:2.4 docker-plugin:1.2.1 git:4.4.5 docker-workflow:1.25 workflow-job:2.40

COPY CI/config.xml.override /usr/share/jenkins/ref/jobs/CI/config.xml.override
COPY CD/config.xml.override /usr/share/jenkins/ref/jobs/CD/config.xml.override

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false




