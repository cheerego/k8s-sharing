#!/bin/bash

docker login --username=419217359@qq.com --password=1234zxcv registry.cn-zhangjiakou.aliyuncs.com

docker build -t registry.cn-zhangjiakou.aliyuncs.com/cheerego/http .

docker push registry.cn-zhangjiakou.aliyuncs.com/cheerego/http