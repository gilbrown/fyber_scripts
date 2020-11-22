cd ..
docker-compose down
cd jenkins
docker build -t fyber/jenkins:lts .
rm -rf /home/jenkins-data/
mkdir /home/jenkins-data/
chmod 777 /home/jenkins-data/
cd ..
docker-compose up -d
