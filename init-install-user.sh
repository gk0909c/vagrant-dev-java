#!/bin/bash

### Eclim Install ###################################################################################
ECLIPSE_URL=http://developer.eclipsesource.com/technology/epp/mars
ECLIPSE_TAR_BALL=eclipse-java-mars-1-linux-gtk-x86_64.tar.gz
ECLIPSE_DIR=eclipse
ECLIM_URL=http://sourceforge.net/projects/eclim/files/eclim/2.5.0
ECLIM_JAR=eclim_2.5.0.jar

wget -nv $ECLIPSE_URL/$ECLIPSE_TAR_BALL
tar -zxf $ECLIPSE_TAR_BALL $ECLIPSE_DIR
rm $ECLIPSE_TAR_BALL

cp /vagrant/.eclimrc ~/

wget -nv $ECLIM_URL/$ECLIM_JAR
java -Dvim.files=$HOME/.vim -Declipse.home=$HOME/$ECLIPSE_DIR -jar $ECLIM_JAR install
rm $ECLIM_JAR

### VIM ############################################################################################
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
cp /vagrant/.vimrc ~/

### MAVEN ##########################################################################################
HTTP_PROXY_HOST=`echo $http_proxy | cut -d ":"  -f 2`
HTTP_PROXY_HOST=${HTTP_PROXY_HOST///}
HTTP_PROXY_PORT=`echo $http_proxy | cut -d ":"  -f 3`

mkdir -p ~/.m2
cat << EOS > ~/.m2/settings.xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">
  <proxies>
    <proxy>
      <id>http_proxy</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>$HTTP_PROXY_HOST</host>
      <port>$HTTP_PROXY_PORT</port>
    </proxy>
    <proxy>
      <id>https_proxy</id>
      <active>true</active>
      <protocol>https</protocol>
      <host>$HTTP_PROXY_HOST</host>
      <port>$HTTP_PROXY_PORT</port>
    </proxy>
  </proxies>
</settings>
EOS

### .bashrc ########################################################################################
echo export JAVA_OPTS=\"-Djava.net.useSystemProxies=true\" >> ~/.bashrc
echo "export TERM=xterm-256color" >> ~/.bashrc
echo "alias mvn-sbr='mvn spring-boot:run'" >> ~/.bashrc
echo "alias view='vim -R'" >> ~/.bashrc
