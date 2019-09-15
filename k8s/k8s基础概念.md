### 基础概念

#### POD
```
Pod，是 Kubernetes 项目中最小的 API 对象
Pod，是 Kubernetes 项目的原子调度单位
凡是调度、网络、存储，以及安全相关的属性，基本上是 Pod 级别的

创建，查询，更新，删除
资源限制
调度约束
重启策略
健康检查
问题定位

```

#### ReplicaSet
```
作用是维持一组 Pod 副本的运行，它的主要作用就是保证一定数量的 Pod 能够在集群中正常运行，它会持续监听这些 Pod 的运行状态，在 Pod 发生故障重启数量减少时重新运行新的 Pod 副本。
```

#### Deployment
```
Deployment 提供了一种对 Pod 和 ReplicaSet 的管理方式，每一个 Deployment 都对应集群中的一次部署。
Deployment 经常会用来创建 ReplicaSet 和 Pod，我们往往不会直接在集群中使用 ReplicaSet 部署一个新的微服务，一方面是因为 ReplicaSet 的功能其实不够强大，一些常见的更新、扩容和缩容运维操作都不支持，Deployment 的引入就是为了就是为了支持这些复杂的操作
```

#### Service
```
Service 一个应用的抽象，是定义POD逻辑集合和访问这个集合的策略。Service 代理 POD 集合对外表现是为一个访问入口，分配集群中的 IP 地址，来自这个IP的请求将负载均衡转发到POD容器中。Service 通过 Label Selector 选择一组 POD 提供服务。
 
网络代理
服务代理
服务发现
发布服务
```

#### Volume
```
共享POD容器的数据。
```

#### PV、PVC、StorageClass
```

```

#### Namespace
```
命名空间，命名空间是具有隔离性的。
```

#### StatefulSet
```
有状态的应用，比如MySQL，Kafka，Redis，具有唯一的网络表示，有序部署
```

#### DaemonSet
```
确保所有或一些节点运行同一个POD，当节点加入集群POD会调度到该节点上
```

#### Job
```
一次性的任务，运行完成后POD就销毁，还可以定时运行
```

