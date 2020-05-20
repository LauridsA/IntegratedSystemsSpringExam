### DOCS ###
## start minikube with virtualbox driver (make sure to disable hyper-v first!)
# minikube start --driver='virtualbox'
## enable ingress on the minikube
# minikube addons enable ingress
### DOCS ###

#cleanup from previous deployments etc
kubectl delete service dependent-service entrypoint-service
kubectl delete deployment dependent entrypoint
#cleanup externals

## entrypoint service ## 
echo "entrypoint deployment + service"
echo "
apiVersion: apps/v1
kind: Deployment
metadata:
  name: entrypoint
spec:
  replicas: 1
  selector:
    matchLabels:
      app: entrypoint
  template:
    metadata:
      labels:
        app: entrypoint
    spec:
      containers:
      - name: entrypoint
        image: gcr.io/kubernetes-e2e-test-images/echoserver:2.1
        ports:
        - containerPort: 8080
" | kubectl apply -f -

echo "
apiVersion: v1
kind: Service
metadata:
  name: entrypoint-service
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: entrypoint
" | kubectl apply -f -

## dependent service ##
echo "dependent deployment + service"

echo "
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dependent
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dependent
  template:
    metadata:
      labels:
        app: dependent
    spec:
      containers:
      - name: dependent
        image: gcr.io/kubernetes-e2e-test-images/echoserver:2.1
        ports:
        - containerPort: 3001
" | kubectl apply -f -


echo "
apiVersion: v1
kind: Service
metadata:
  name: dependent-service
spec:
  ports:
  - port: 80
    targetPort: 3001
    protocol: TCP
    name: http
  selector:
    app: dependent
" | kubectl apply -f -

# kubectl apply -f ../deployment.yaml