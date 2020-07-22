# Zookeeper，Kafka部署步骤

## ZooKeeper    

https://archive.cloudera.com/cdh5/cdh/5/

ssh hadoop@192.168.199.233

- 从~/software下解压到~/app目录下
  
   - `tar -zxvf zookeeper-3.4.5-cdh5.15.1.tar.gz -C  ~/app`
   
- 配置系统环境变量  ~/.bash_profile

- ![image-20200709160020449](../images/image-20200709160020449.png)
  	
  	
  
  - 使用 `source ~/.bash_profile`刷新环境变量
  
- 使用 `echo $ZK_HOME`判断环境变量是否生效

- 配置文件  $ZK_HOME/conf/zoo.cfg  dataDir不要放在默认的/tmp下
   - `cp zoo_sample.cfg zoo.cfg`
   - `vim zoo.cfg`
   - dataDir不要放在默认的/tmp下，系统tmp会在系统重启的时候全部删除
   - ![image-20200709160733057](../images/image-20200709160733057.png)
   
- 启动ZK   

   - ```
      $ZK_HOME/bin/zkServer.sh start
      ```

- 检查是否启动成功   `jps ` 如果有这个QuorumPeerMain进程，则启动成功

## Kafka

wget http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/1.1.1/kafka_2.11-1.1.1.tgz
	
ssh hadoop@192.168.199.233

- 从~/software下解压到~/app目录下

- 配置系统环境变量  ~/.bash_profile

- 配置文件 $KAFKA_HOME/config/server.properties
	
	- log.dirs 不要放在默认的/tmp下
	- ![image-20200709163824155](../images/image-20200709163824155.png)
	- ![image-20200709163747897](../images/image-20200709163747897.png)
	
- 启动Kafka 

  - ```
    $KAFKA_HOME/bin/kafka-server-start.sh -daemon /home/hadoop/app/kafka_2.11-1.1.1/config/server.properties
    ```

- 检查是否启动成功 `jps Kafka`

- 创建topic

  ```
  ./kafka-topics.sh --create --zookeeper 127.0.0.1:2181 --replication-factor 1 --partitions 1 --topic tyraeltest
  ```

- 查看所有的topic

  ```
  ./kafka-topics.sh --list --zookeeper 127.0.0.1:2181
  ```

- 启动生产者

  ```
  ./kafka-console-producer.sh --broker-list 127.0.0.1:9092 --topic tyraeltest
  ```

- 启动消费者

  ```
  ./kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic tyraeltest
  ```


## ElasticSearch 部署

下载ElasticSearch，解压

修改config目录下的network配置，修改为0.0.0.0

进入bin目录，启动elasticsearch，如果windows则启动.bat文件，需要在后台运行则使用

```
./elasticsearch.bat -d
```

