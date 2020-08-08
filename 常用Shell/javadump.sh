#!/bin/sh



DUMP_PIDS=`ps  --no-heading -C java -f --width 1000 |awk '{print $2}'`
if [ -z "$DUMP_PIDS" ]; then
    echo "The server $HOST_NAME is not started!"
    exit 1;
fi

DUMP_ROOT=~/dump
if [ ! -d $DUMP_ROOT ]; then
	mkdir $DUMP_ROOT
fi

DUMP_DATE=`date +%Y%m%d%H%M%S`
DUMP_DIR=$DUMP_ROOT/dump-$DUMP_DATE
if [ ! -d $DUMP_DIR ]; then
	mkdir $DUMP_DIR
fi

for PID in $DUMP_PIDS ; do
#Full thread dump �������߳�ռ�ã�����������
	$JAVA_HOME/bin/jstack $PID > $DUMP_DIR/jstack-$PID.dump 2>&1
	echo -e ".\c"
#��ӡ��һ��������Java���̡�Java core�ļ���Զ��Debug��������Java������Ϣ���������Javaϵͳ���Ժ�JVM�����в�����
	$JAVA_HOME/bin/jinfo $PID > $DUMP_DIR/jinfo-$PID.dump 2>&1
	echo -e ".\c"
#jstat�ܹ���̬��ӡjvm(Java Virtual Machine Statistics Monitoring Tool)�����ͳ����Ϣ����young gcִ�еĴ�����full gcִ�еĴ����������ڴ�����Ŀռ��С�Ϳ�ʹ��������Ϣ��	
	$JAVA_HOME/bin/jstat -gcutil $PID > $DUMP_DIR/jstat-gcutil-$PID.dump 2>&1
	echo -e ".\c"
	$JAVA_HOME/bin/jstat -gccapacity $PID > $DUMP_DIR/jstat-gccapacity-$PID.dump 2>&1
	echo -e ".\c"
#δָ��ѡ��ʱ��jmap��ӡ��������ӳ�䡣��ÿ��Ŀ��VM���صĹ����������ʼ��ַ��ӳ���С����������ļ�������·��������ӡ������	
	$JAVA_HOME/bin/jmap $PID > $DUMP_DIR/jmap-$PID.dump 2>&1
	echo -e ".\c"
#-heap��ӡ������ĸ�Ҫ��Ϣ�����������ã����ѿռ����������ʹ�úͿ������	
	$JAVA_HOME/bin/jmap -heap $PID > $DUMP_DIR/jmap-heap-$PID.dump 2>&1
	echo -e ".\c"
#-dump��jvm�Ķ����ڴ���Ϣ�����һ���ļ���,Ȼ�����ͨ��eclipse memory analyzer���з���
#ע�⣺���jmapʹ�õ�ʱ��jvm�Ǵ��ڼ���״̬�ģ�ֻ���ڷ���̱����ʱ��Ϊ�˽��������ʹ�ã��������ɷ����жϡ� 
	$JAVA_HOME/bin/jmap -dump:format=b,file=$DUMP_DIR/jmap-dump-$PID.dump $PID 2>&1
	echo -e ".\c"
#��ʾ�����̴򿪵��ļ���Ϣ
if [ -r /usr/sbin/lsof ]; then
	/usr/sbin/lsof -p $PID > $DUMP_DIR/lsof-$PID.dump
	echo -e ".\c"
	fi
done
#��Ҫ�����ռ����㱨��洢ϵͳ������Ϣ�ġ�
if [ -r /usr/bin/sar ]; then
/usr/bin/sar > $DUMP_DIR/sar.dump
echo -e ".\c"
fi
#��Ҫ�����ռ����㱨��洢ϵͳ������Ϣ�ġ�
if [ -r /usr/bin/uptime ]; then
/usr/bin/uptime > $DUMP_DIR/uptime.dump
echo -e ".\c"
fi
#�ڴ�鿴
if [ -r /usr/bin/free ]; then
/usr/bin/free -t > $DUMP_DIR/free.dump
echo -e ".\c"
fi
#���Եõ����ڽ��̡��ڴ桢�ڴ��ҳ������IO��traps��CPU�����Ϣ��
if [ -r /usr/bin/vmstat ]; then
/usr/bin/vmstat > $DUMP_DIR/vmstat.dump
echo -e ".\c"
fi
#������CPU��ص�һЩͳ����Ϣ
if [ -r /usr/bin/mpstat ]; then
/usr/bin/mpstat > $DUMP_DIR/mpstat.dump
echo -e ".\c"
fi
#������IO��ص�һЩͳ����Ϣ
if [ -r /usr/bin/iostat ]; then
/usr/bin/iostat > $DUMP_DIR/iostat.dump
echo -e ".\c"
fi
#������������ص�һЩͳ����Ϣ
if [ -r /bin/netstat ]; then
/bin/netstat > $DUMP_DIR/netstat.dump
echo -e ".\c"
fi
echo "OK!"