git pull
curpwd=$(pwd)
cd ..

#docker run -d -p 8510:8500 --restart=always -v /XiLife/consul/data/server1:/consul/data -v /XiLife/consul/conf/server1:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_1 consul:latest agent -server -bootstrap-expect=3 -ui -node=consul_server_1 -client='0.0.0.0' -data-dir /consul/data -config-dir /consul/config -datacenter=xdp_dc;

#docker run -d -p 8511:8500 --restart=always -v /XiLife/consul/data/server2:/consul/data -v /XiLife/consul/conf/server2:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_2 consul:latest agent -server -ui -node=consul_server_2 -client='0.0.0.0' -datacenter=xdp_dc -data-dir /consul/data -config-dir /consul/config -join=$JOIN_IP

#docker run -d -p 8512:8500 --restart=always -v /XiLife/consul/data/server3:/consul/data -v /XiLife/consul/conf/server3:/consul/config -e CONSUL_BIND_INTERFACE='eth0' --privileged=true --name=consul_server_3 consul:latest agent -server -ui -node=consul_server_3 -client='0.0.0.0' -datacenter=xdp_dc -data-dir /consul/data -config-dir /consul/config -join=$JOIN_IP

docker build -f ./src/ServiceA/Dockerfile -t serivceaimg:v1.0 .
docker run -d -p 8580:80 serivceaimg:v1.0

docker build -f ./src/ServiceB/Dockerfile -t serivcebimg:v1.0 .
docker run -d -p 8560:80 serivcebimg:v1.0

docker image prune -f