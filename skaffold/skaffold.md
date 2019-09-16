### Skaffold

#### Skaffold 是什么
```
简单来说：它是一个具有Build镜像,Deploy到K8S,Profiles环境分发。
```


#### Skaffold 基础配置

* [Builder](https://skaffold.dev/docs/how-tos/builders/)
* [Tagger](https://skaffold.dev/docs/how-tos/taggers/)
* [Deployer](https://skaffold.dev/docs/how-tos/deployers/)
* [Profile](https://skaffold.dev/docs/how-tos/profiles/)

### Example

#### Base
```
apiVersion: skaffold/v1beta1
kind: Config
build:
  artifacts:
    - image: registry.cn-zhangjiakou.aliyuncs.com/cheerego/http
deploy:
  kubectl:
    manifests:
      - k8s-*
```


#### Profile
```
apiVersion: skaffold/v1beta1
kind: Config
profiles:
  - name: test
    build:
      artifacts:
        - image: registry.cn-zhangjiakou.aliyuncs.com/cheerego/http
          docker:
            buildArgs:
              SET_NODE_ENV: hkn
    deploy:
      kubectl:
        manifests:
          - k8s-*
```