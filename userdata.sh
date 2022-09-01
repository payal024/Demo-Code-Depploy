#!/usr/bin/bash

#!/bin/bash
sudo su
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo “Hello World from $(hostname -f)” > /var/www/html/index.html

# sudo yum update -y
# sudo su
# echo "Installing Java 11.."
# sudo yum install java-11-amazon-corretto-headless -y 
# sudo yum install java-11-amazon-corretto -y 
# echo 3 | sudo alternatives --config java

# #maveninstalltion
# cd /opt/
# sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
# sudo tar xvf apache-maven-3.8.6-bin.tar.gz
# sudo mv apache-maven-3.8.6  /usr/local/apache-maven
# sudo echo 'export M2_HOME=/usr/local/apache-maven' >> ~/.bashrc
# sudo echo 'export M2=$M2_HOME/bin' >> ~/.bashrc  
# sudo echo 'export PATH=$M2:$PATH' >> ~/.bashrc
# sudo source ~/.bashrc
# mvn -version


# ## Verifying Tomcat Installation Directory ##
# sudo cd /usr/share
# mkdir tomcat 
# sudo  amazon-linux-extras install tomcat8.5 -y
# sudo  systemctl start tomcat
# sudo cd /usr/share/tomcat/webapps/
# sudo wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

# ## Tomcat Install
# sudo yum install tomcat8-webapps tomcat8-admin-webapps -y
# cd /usr/share/tomcat/webapps
# sudo mkdir ROOT
# cd ROOT/
# sudo echo '<html>Healthy!</html>' &>>health-check
# sudo systemctl restart tomcat
# #Testing tomcat
# sudo amazon-linux-extras install tomcat8.5 -y
# #sudo systemctl start tomcat
# cd /usr/share/tomcat/webapps
# sudo mkdir /usr/share/tomcat/webapps/ROOT
# sudo -s <<EOF
# #echo Now i am root
# #sudo touch /usr/share/tomcat/webapps/ROOT/index.html
# sudo chown tomcat:"$USER" /usr/share/tomcat/webapps/ROOT/index.html
# echo '<html>Healthy</html>'> /usr/share/tomcat/webapps/ROOT/health-check
# EOF 
# sudo systemctl restart tomcat