cat ~/Dockerlogin/password.txt | docker login --username lauridsand --password-stdin
docker build -f ../DependentService/Dockerfile -t lauridsand/entrypoint-service:latest ../DependentService/
docker build -f ../EntrypointService/Dockerfile -t lauridsand/dependent-service:latest ../EntrypointService/
#push it to the registry
docker push lauridsand/entrypoint-service:latest
docker push lauridsand/dependent-service:latest

kubectl apply -f ../deployment.yaml