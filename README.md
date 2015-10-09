# Vagrant Setting for Java Development
create vm for java development on vagrant

## Box
fix Vagrantfile and specify your box.
now I comfirmed only on ubuntu.


## Environment on vagrant
* Java : jdk-8u60-linux-x64
* Maven : 3.3.3
* Vim : latest
* Eclipse : Mars
* Eclim : 2.5.0

if you want other version, fix shell script file.

## Other
if you are behind proxy
* set variable 'http_proxy' and 'NO_PROXY environment' on your host machine

if you are not behind proxy
* comment out proxy describe in Vagrantfile
* remove describe that create maven settings.xml, in init-install-user.sh



