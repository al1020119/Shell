#!/bin/bash
# $1 消费数据的主题
/root/apps/kafka_2.11-0.10.2.1/bin/kafka-console-consumer.sh --bootstrap-server test02:9092,test03:9092,test04:9092 --from-beginning --topic $1
