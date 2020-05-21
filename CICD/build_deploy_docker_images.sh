#docker login
cat ~/Dockerlogin/password.txt | docker login --username lauridsand --password-stdin
#build images
docker build -f ../EntrypointService/Dockerfile -t lauridsand/entrypoint-service:latest ../EntrypointService/
docker build -f ../DependentService/Dockerfile -t lauridsand/dependent-service:latest ../DependentService/
#push it to the registry
docker push lauridsand/entrypoint-service:latest
docker push lauridsand/dependent-service:latest