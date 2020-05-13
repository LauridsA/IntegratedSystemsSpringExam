
docker build -f ../DependentService/Dockerfile -t entrypoint-python:latest ../DependentService/
docker build -f ../EntrypointService/Dockerfile -t dependent-service:latest ../EntrypointService/
# kubectl apply -f deployment.yaml