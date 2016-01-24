# build as bioconductor/bbs-docker

# Assumes you want R-devel, if not, need to change this:
FROM bioconductor/devel_base


# build-time arguments, with default values:
ARG R_VERSION=3.3
ARG BIOC_VERSION=3.3

# the following statements make them persist in the built
# image:
ENV BIOC_VERSION=$BIOC_VERSION
ENV R_VERSION=$R_VERSION

# You can override those argument values by using
# build-arg in your docker build command:
# --build-arg R_VERSION=3.2 --build-arg BIOC_VERSION=3.2 ...




# NOTE: Basing this on one of the Bioconductor 
# Docker images means R is in the PATH, which
# is NOT the case on the actual build nodes.


MAINTAINER dtenenba@fredhutch.org

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl openssh-server python-pip rsync ssh zip

# ssh stuff
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN pip install ipython

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

RUN  useradd -d /home/biocbuild -m -s /bin/bash biocbuild
RUN  useradd -d /home/biocadmin -m -s /bin/bash biocadmin

USER biocadmin

RUN mkdir -p /home/biocadmin/bin && \
  ln -s /usr/local/bin/R /home/biocadmin/bin/R-$R_VERSION && \
  mkdir -p /home/biocadmin/PACKAGES/$BIOC_VERSION/bioc/ && \
  cd /home/biocadmin/PACKAGES/$BIOC_VERSION/bioc && \
  mkdir -p manuals src/contrib bin/windows/contrib/$R_VERSION \
    bin/macosx/contrib/3.2 bin/macosx/mavericks/contrib/$R_VERSION && cd

USER biocbuild

RUN mkdir /home/biocbuild/.ssh /home/biocbuild/.BBS
ADD id_rsa /home/biocbuild/.BBS/id_rsa

USER root

RUN chmod go-rwx /home/biocbuild/.BBS/id_rsa


ADD id_rsa.pub /home/biocbuild/.ssh/authorized_keys
RUN chown biocbuild:biocbuild /home/biocbuild/.BBS/id_rsa /home/biocbuild/.ssh/authorized_keys

USER biocbuild

#RUN echo "alias st='cd ~/BBS/$BIOC_VERSION/bioc/dockernode &&  . config.sh &&  cd'" > /home/biocbuild/.bash_profile

#RUN mkdir -p ~/public_html/BBS/$BIOC_VERSION

#VOLUME /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc

#VOLUME /home/biocbuild/BBS

RUN mkdir -p ~/bbs-$BIOC_VERSION-bioc/R/bin
RUN mkdir ~/bbs-$BIOC_VERSION-bioc/log
RUN ln -s /usr/local/bin/R ~/bbs-$BIOC_VERSION-bioc/R/bin/R

USER root

RUN echo "cd ~/BBS/$BIOC_VERSION/bioc/dockernode && . config.sh && cd" > /home/biocbuild/.bash_profile

ADD biocbuild /bin/biocbuild
ADD biocadmin /bin/biocadmin

#RUN echo "#!/bin/bash\n /usr/sbin/sshd && su - biocbuild && python -m SimpleHTTPServer 80 > /dev/null 2>&1 &  && bash" > /bin/biocbuild && chmod +x /bin/biocbuild
#RUN echo "#!/bin/bash\nsu - biocadmin && bash" > /bin/biocadmin && chmod +x /bin/biocadmin

CMD biocbuild

