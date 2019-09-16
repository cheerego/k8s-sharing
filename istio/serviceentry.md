### ServiceEntry


```
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: http
spec:
  hosts:
    - "www.baidu.com"
    - "wp.makex.io"
  ports:
    - number: 443
      name: https
      protocol: TLS
    - number: 80
      name: http
      protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL
  exportTo:
    - "*"
```



```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sleep
  labels:
    app: sleep
spec:
  replicas: 1
  template:
    metadata:
      name: sleep
      labels:
        app: sleep
    spec:
      containers:
        - name: sleep
          image: pstauffer/curl
          imagePullPolicy: IfNotPresent
          command: ["/bin/sleep", "3650d"]
      restartPolicy: Always
  selector:
    matchLabels:
      app: sleep

```


