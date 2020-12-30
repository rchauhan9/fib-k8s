docker build -t rchauhan9/multi-client:latest -t rchauhan9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rchauhan9/multi-server:latest -t rchauhan9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rchauhan9/multi-worker:latest -t rchauhan9/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rchauhan9/multi-client:latest
docker push rchauhan9/multi-server:latest
docker push rchauhan9/multi-worker:latest

docker push rchauhan9/multi-client:$SHA
docker push rchauhan9/multi-server:$SHA
docker push rchauhan9/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=rchauhan9/multi-server:$SHA
kubectl set image deployments/client-deployment client=rchauhan9/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rchauhan9/multi-worker:$SHA