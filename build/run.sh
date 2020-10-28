git pull
curpwd=$(pwd)
cd ..
docker rm $(docker ps -a -q)

echo -e "\033[33m 是否启动consul\033[0m"
echo "y 是"
echo "n 否"
read start_con
if [ $start_con == "y" ] 
then
    JOIN_IP="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' consul_server_1_master)";
    docker stop $(docker ps | grep consul | awk '{print $1}')
    docker rm $(docker ps -qf status=exited)
    docker run -d -p 8500:8500 --restart=always -v /data/consul/data/server1:/consul/data -v /data/consul/conf/server1:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_1_master consul:latest agent -server -bootstrap-expect=2 -ui -node=consul_server_1_master -client='0.0.0.0' -data-dir /consul/data -config-dir /consul/config -datacenter=dc1;
    docker run -d -p 8501:8500 --restart=always -v /data/consul/data/server2:/consul/data -v /data/consul/conf/server2:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_2 consul:latest agent -server -ui -node=consul_server_2 -client='0.0.0.0' -datacenter=dc1 -data-dir /consul/data -config-dir /consul/config -join=$JOIN_IP
    docker run -d -p 8502:8500 --restart=always -v /data/consul/data/server3:/consul/data -v /data/consul/conf/server3:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_3 consul:latest agent -server -ui -node=consul_server_3 -client='0.0.0.0' -datacenter=dc1 -data-dir /consul/data -config-dir /consul/config -join=$JOIN_IP
fi

docker build -f ./src/ServiceA/Dockerfile -t serivceaimg:v1.0 .
docker run -d -p 8580:80 serivceaimg:v1.0

docker build -f ./src/ServiceB/Dockerfile -t serivcebimg:v1.0 .
docker run -d -p 8560:80 serivcebimg:v1.0

docker image prune -f