### 部署Nginx

#### Deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 1
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
        version: v1
    spec:
      containers:
        - name: nginx
          image: nginx
          imagePullPolicy: IfNotPresent
      restartPolicy: Always
  selector:
    matchLabels:
      app: nginx
```


#### Service
```
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  ports:
    - port: 80
```


#### VirtualService
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: nginx
spec:
  hosts:
    - "nginx.k8s.front-end.cn"
    - nginx
  gateways:
    - gateway/makex-gateway
  http:
    - route:
        - destination:
            host: nginx
            port:
              number: 80
            subset: v1
```