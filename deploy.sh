docker build -t nikitakot/multi-client:latest -t nikitakot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikitakot/multi-server:latest -t nikitakot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikitakot/multi-worker:latest -t nikitakot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikitakot/multi-client:latest
docker push nikitakot/multi-server:latest
docker push nikitakot/multi-worker:latest

docker push nikitakot/multi-client:$SHA
docker push nikitakot/multi-server:$SHA
docker push nikitakot/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikitakot/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikitakot/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikitakot/multi-worker:$SHA