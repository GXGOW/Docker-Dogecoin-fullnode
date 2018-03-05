# Quick rebuild script

docker stop dogenode
docker rm dogenode
docker rmi dogeimage
docker build -t='dogeimage' .
docker run -p 9333:9333 --name dogenode dogeimage