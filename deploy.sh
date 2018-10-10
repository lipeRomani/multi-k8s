docker build -t felipearomani/multi-client:latest -t felipearomani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t felipearomani/multi-server:latest -t felipearomani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t felipearomani/multi-worker:latest -t felipearomani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push felipearomani/multi-client:latest
docker push felipearomani/multi-server:latest
docker push felipearomani/multi-worker:latest

docker push felipearomani/multi-client:$SHA
docker push felipearomani/multi-server:$SHA
docker push felipearomani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=felipearomani/multi-server:$SHA
kubectl set image deployments/client-deployment client=felipearomani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=felipearomani/multi-worker:$SHA