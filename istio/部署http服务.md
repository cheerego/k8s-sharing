### 部署HTTP

#### Deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: http-v1
  labels:
    app: http
spec:
  replicas: 2
  template:
    metadata:
      name: http
      labels:
        app: http
        version: v1
    spec:
      containers:
        - name: http
          image: registry.cn-zhangjiakou.aliyuncs.com/cheerego/http
          imagePullPolicy: Always
          env:
            - name: VERSION
              value: v1
      restartPolicy: Always
      imagePullSecrets:
        - name: cheerego
  selector:
    matchLabels:
      app: http
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: http-v2
  labels:
    app: http
spec:
  replicas: 1
  template:
    metadata:
      name: http
      labels:
        app: http
        version: v2
    spec:
      containers:
        - name: http
          image: registry.cn-zhangjiakou.aliyuncs.com/cheerego/http
          imagePullPolicy: Always
          env:
            - name: VERSION
              value: v2
      restartPolicy: Always
      imagePullSecrets:
        - name: cheerego
  selector:
    matchLabels:
      app: http

```


#### Service
```
apiVersion: v1
kind: Service
metadata:
  name: http
spec:
  selector:
    app: http
  ports:
    - port: 8080
```


#### VirtualService
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: http
spec:
  hosts:
    - "http.k8s.front-end.cn"
    - http
  gateways:
    - gateway/makex-gateway
  http:
    - route:
        - destination:
            host: http
            port:
              number: 8080
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: http
spec:
  host: http
  trafficPolicy:
    loadBalancer:
      simple: RANDOM
    outlierDetection:
      baseEjectionTime: 2m
      consecutiveErrors: 5
      interval: 15.000s
      maxEjectionPercent: 100
  subsets:
    - name: v1
      labels:
        version: v1
    - name: v2
      labels:
        version: v2
```