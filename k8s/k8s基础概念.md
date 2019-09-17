### 基础概念
#### Kubernetes是什么
Kubernetes 是一个自动化部署、伸缩和操作应用程序容器的开源平台。

为什么使用容器，容器具有隔离和限制的作用，而且可以保证环境的一致性。

首先，Kubernetes 项目要解决的问题是什么？

编排？调度？容器云？还是集群管理？

容器的运行平台：现在我有了应用的容器镜像，请帮我在一个给定的集群上把这个应用的容器镜像，请帮我在一个给定的集群上把这个应用运行起来。

运维平台：我还希望 Kubernetes 能给我提供路由网关、水平扩展，监控、备份、灾难恢复等。

这些功能Docker+swarm 也有啊。

K8S还提供了，调用网络插件和存储插件为容器配置网络和持久化存储。

微服务：当然，如果只做到“封装微服务、调度单容器”这一层次，Docker Swarm 项目就已经绰绰有余了。
如果再加上 Compose 项目，你甚至还具备了处理一些简单依赖关系的能力。
                              
Kubernetes 项目最主要的设计思想是，从更宏观的角度，以统一的方式来定义任务之间的各种关系，并且为将来支持更多种关系，并且为将来支持更多种类的关系留有余地。

![avatar](../POD核心功能全景图.png)     



#### 声明式API

为此，Kubernetes 定义了新的、基于 Pod 改进后，比如 Job，用来描述一次性运行的 Pod；
再比如 DaemonSet，用来描述每个宿主机上必须且只能运行一个副本的守护进程服务；
又比如 CronJob，则用于描述定时任务等等。

相比之下，在 Kubernetes 项目中，我们所推崇的使用方法是：
首先，通过一个“编排对象”，比如 Pod、Job、CronJob 等，来描述你试图管理的应用；
然后，再为它定义一些“服务对象”，比如 Service、Secret、Horizontal Pod Autoscaler（自动水平扩展器）等。这些对象，会负责具体的平台级功能。                               

#### POD
```

Pod，是 Kubernetes 项目中最小的 API 对象
Pod，是 Kubernetes 项目的原子调度单位
凡是调度、网络、存储，以及安全相关的属性，基本上是 Pod 级别的

一个POD由一个或多个容器组成，POD中的容器共享存储，网络

创建，查询，更新，删除
资源限制
调度约束
重启策略
健康检查
问题定位


为什么在kubernetes我们不直接使用一个单独的容器（container），而是用pod来封装一个或多个容器呢？

Pod就是一组容器的集合，在Pod里面的容器共享网络/存储（kubernetes实现共享一组的namespace去替代每个container各自的NS，来实现这种能力），所以它们可以通过localhost进行内部的通信。
虽然网络存储都是共享的，但是cpu和memory就不是。多容器之间可以有属于自己的cgroup，也就是说我们可以单独的对Pod中的容器做资源（MEM/CPU）使用的限制。


所以，在 Kubernetes 项目里，Pod 的实现需要使用一个中间容器，这个容器叫作 Infra 容器。在这个 Pod 中，Infra 容器永远都是第一个被创建的容器，而其他用户定义的容器，则通过 Join Network Namespace 的方式，与 Infra 容器关联在一起。这样的组织关系，可以用下面这样一个示意图来表达：

pod是一个小家庭，它把密不可分的家庭成员(container)聚在一起，Infra container则是家长，掌管家中共通资源，家庭成员通过sidecar方式互帮互助，其乐融融～

```

![avatar](../POD核心.png)


如上图所示，这个 Pod 里有两个用户容器 A 和 B，还有一个 Infra 容器。很容易理解，在 Kubernetes 项目里，Infra 容器一定要占用极少的资源，所以它使用的是一个非常特殊的镜像，叫作：k8s.gcr.io/pause。
这个镜像是一个用汇编语言编写的、永远处于“暂停”状态的容器，解压后的大小也只有 100~200 KB 左右。     

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
Service 是一个概念，主要做到分发作用的是每个节点上的 kube-proxy
早起的kube-proxy 通过 IPtable 实现：kube-proxy 和 Api Server 交互 Watch Service的改变，然后修改 IPtable，有一个缺点就是服务变多了之后 kube-proxy 维护的 iptable 就会变得很庞大。
后来kube-proxy 改成了 ipvs（IP virtual Server）

K8S是如何进行服务发现的？


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

