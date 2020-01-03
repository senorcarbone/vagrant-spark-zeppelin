#!/usr/bin/env bash

echo "Updating System"
apt-get update
apt-get install -y vim net-tools
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install -y openjdk-8-jdk

update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
java -version

cat > /home/vagrant/.bash_aliases <<EOF
alias l1='ls -1 --color'
alias ll='ls -la --color'
alias lh='ls -lah --color'
alias grep='egrep --color'
EOF

. /home/vagrant/.bash_aliases
