git pull
curpwd=$(pwd)
cd ..
docker build -f ./src/ServiceA/Dockerfile -t serivceaimg:v1.0 .
docker run -d -p 8580:80 serivceaimg:v1.0

docker build -f ./src/ServiceB/Dockerfile -t serivcebimg:v1.0 .
docker run -d -p 8560:80 serivcebimg:v1.0
