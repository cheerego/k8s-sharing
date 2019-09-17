### Helm 

#### What's helm ?
K8S应用的包管理工具


#### Usage

* 第一次使用需要 helm init,他会在k8s中创建服务端名为 tiller 的 pod
* helm 是客户端工具
* 创建一个自己 chart `helm create demo`

```
demo
├── Chart.yaml
├── charts
├── templates
│   ├── NOTES.txt
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml
```

#### 类比
* 可以将Helm看成K8S下的Maven或者npm
* 每一个包称之为Chart，相当于Java的jar包
* 相对于应用发布者来说，可以通过Helm打包应用，管理应用依赖关系，管理应用版本发布到软件仓库
* 对于使用者而言，使用Helm不需要了解K8S的Yaml语法，编写应用配置文件
* Helm 也提供了软件部署，删除，升级，回滚的功能

#### 术语

https://whmzsu.github.io/helm-doc-zh-cn/glossary-zh_cn.html



