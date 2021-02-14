docker build -t hsefati/multi-client:latest -t hsefati/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hsefati/multi-server:latest -t hsefati/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hsefati/multi-worker:latest -t hsefati/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hsefati/multi-client:latest
docker push hsefati/multi-server:latest
docker push hsefati/multi-worker:latest
docker push hsefati/multi-client:$SHA
docker push hsefati/multi-server:$SHA
docker push hsefati/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hsefati/multi-server:$SHA
kubectl set image deployments/client-deployment client=hsefati/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hsefati/multi-worker:$SHA
