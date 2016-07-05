FROM ubuntu:14.04
MAINTAINER Mikhail Kozhevnikov 

#Environments
##
ENV DEPLOY_USER deploy
ENV HOME_DIR /home/$DEPLOY_USER
ENV RUBY_VER 2.3.1


#Create Deploy User
##
RUN useradd -c 'Deploy User' -s /bin/bash -u 1001 -m -d $HOME_DIR $DEPLOY_USER
#RUN echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
#RUN usermod  -g sudo $DEPLOY_USER

#install Ruby
###

#install some dependencies for Ruby
##
RUN apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y install libyaml-dev libffi-dev git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties \
 && apt-get -q clean \ 
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $DEPLOY_USER

#install rbenv
##
RUN git clone https://github.com/rbenv/rbenv.git $HOME_DIR/.rbenv \
 && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME_DIR/.bashrc \
 && echo 'eval "$(rbenv init -)"' >> $HOME_DIR/.bashrc

#install ruby-build
##
RUN git clone https://github.com/rbenv/ruby-build.git $HOME_DIR/.rbenv/plugins/ruby-build \ 
 && echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME_DIR/.bashrc \
 && export PATH="$HOME/.rbenv/bin:$PATH"
