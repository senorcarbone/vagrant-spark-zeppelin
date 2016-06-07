#!/usr/bin/env bash

# APACHE ZEPPELIN
export MAVEN_VERSION=3.3.1
export MAVEN_HOME=/usr/apache-maven-$MAVEN_VERSION

export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_EXAMPLES_DIR=${ZEPPELIN_HOME}/examples
export ZEPPELIN_PORT=8080

apt-get install -y git wget net-tools unzip python npm

ln -fs /usr/bin/nodejs /usr/bin/node

wget -c "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/
ln -s ${MAVEN_HOME} /usr/maven

git clone https://github.com/senorcarbone/incubator-zeppelin.git ${ZEPPELIN_HOME} 
cd ${ZEPPELIN_HOME}
git fetch
git checkout zeppelics

#${MAVEN_HOME}/bin/mvn clean package -Pspark-1.4 -Dhadoop.version=2.4.0 -Phadoop-2.4 -DskipTests

${MAVEN_HOME}/bin/mvn clean package -DskipTests

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
CONF

echo "Copying Example Notebooks ..."
cp -vR /vagrant/examples/* /usr/zeppelin/notebook/

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start
