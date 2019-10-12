# build images
docker build -t karthik530/multi-client -t karthik530/multi-client:$SHA client
docker build -t karthik530/multi-server -t karthik530/multi-server:$SHA server
docker build -t karthik530/multi-worker -t karthik530/multi-worker:$SHA worker

# push images with latest to docker hub
docker push karthik530/multi-client
docker push karthik530/multi-server
docker push karthik530/multi-worker

# push images with SHA to docker hub
docker push karthik530/multi-client:$SHA
docker push karthik530/multi-server:$SHA
docker push karthik530/multi-worker:$SHA

# configure/apply k8 configs using kubectl
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karthik530/multi-server:$SHA
kubectl set image deployments/client-deployment client=karthik530/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karthik530/multi-worker:$SHA