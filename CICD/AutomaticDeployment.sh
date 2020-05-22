### DOCS ###
## start minikube with virtualbox driver (make sure to disable hyper-v first!)
# minikube start --driver='virtualbox'
## enable ingress on the minikube
# minikube addons enable ingress
### DOCS ###

#cleanup from previous deployments etc
kubectl delete service dependent-service entrypoint-service
kubectl delete deployment dependent entrypoint
kubectl delete ingress is-ingress

## Ingress ##
echo "####ingress deployment####"
echo "
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: is-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: \"false\"
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: entrypoint-service
          servicePort: 80
      - path: /dependentservice
        backend:
          serviceName: dependent-service
          servicePort: 80
" | kubectl apply -f -

## entrypoint service ## 
echo "####entrypoint deployment + service####"
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
        image: docker.io/lauridsand/entrypoint-service:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
" | kubectl apply -f -

echo "
apiVersion: v1
kind: Service
metadata:
  name: entrypoint-service
  namespace: default
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
echo "####dependent deployment + service####"

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
        image: docker.io/lauridsand/dependent-service:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
" | kubectl apply -f -


echo "
apiVersion: v1
kind: Service
metadata:
  name: dependent-service
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: dependent
" | kubectl apply -f -

# kubectl apply -f ../deployment.yaml