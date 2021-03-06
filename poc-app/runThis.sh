docker build -t myapp .
docker tag myapp gcr.io/playground-s-11-db06c9f0/myapp
docker push gcr.io/playground-s-11-db06c9f0/myapp
gcloud container clusters get-credentials poc-cluster --zone="us-east1-d"
kubectl create deployment myapp --image=gcr.io/playground-s-11-db06c9f0/myapp
kubectl expose deployment myapp --type=LoadBalancer --port 80
kubectl get service myapp
