#ɾ��temp�ļ����ظ���
awk '!($0 in array) { array[$0]; print }' temp

#�鿴�ʹ�õ�10��unix����
awk '{print $1}' ~/.bash_history | sort | uniq -c | sort -rn | head -n 10

#�鿴������ip�б�
ifconfig -a | awk '/Bcast/{print $2}' | cut -c 5-19

#�鿴������ÿ��Զ�����ӻ�����������
netstat -antu | awk '$5 ~ /[0-9]:/{split($5, a, ":"); ips[a[1]]++} END {for (ip in ips) print ips[ip], ip | "sort -k1 -nr"}'

#�鿴ĳ�����̴򿪵�socket����
ps aux | grep [process] | awk '{print $2}' | xargs -I % ls /proc/%/fd | wc -l


#�鿴���������ip
sudo ifconfig wlan0 | grep inet | awk 'NR==1 {print $2}' | cut -c 6-

#�����������ļ�
find . -name '*.jpg' | awk 'BEGIN{ a=0 }{ printf "mv %s name%01d.jpg\n", $0, a++ }' | bash

#�鿴ĳ���û��򿪵��ļ�����б�
for x in `ps -u 500 u | grep java | awk '{ print $2 }'`;do ls /proc/$x/fd|wc -l;done

#�����ļ�temp�ĵ�һ�е�ֵ�ĺ�
awk '{s+=$1}END{print s}' temp

#�鿴��õ������ʹ�ô���
history | awk '{if ($2 == "sudo") a[$3]++; else a[$2]++}END{for(i in a){print a[i] " " i}}' |  sort -rn | head

#����ĳ��ʱ������ļ��б�
cp -p `ls -l | awk '/Apr 14/ {print $NF}'` /usr/users/backup_dir

#��ʽ�������ǰ�Ľ�����Ϣ
ps -ef | awk -v OFS="\n" '{ for (i=8;i<=NF;i++) line = (line ? line FS : "") $i; print NR ":", $1, $2, $7, line, ""; line = "" }'

#�鿴�������ݵ��ض�λ�õĵ����ַ�
echo "abcdefg"|awk 'BEGIN {FS="''"} {print $2}'

#��ӡ�к�
ls | awk '{print NR "\t" $0}'

#��ӡ��ǰ��ssh �ͻ���
netstat -tn | awk '($4 ~ /:22\s*/) && ($6 ~ /^EST/) {print substr($5, 0, index($5,":"))}'

#��ӡ�ļ���һ�в�ֵͬ����
awk '!array[$1]++' file.txt

#��ӡ�ڶ���Ψһֵ
awk '{ a[$2]++ } END { for (b in a) { print b } }' file

#�鿴ϵͳ���з���
awk '{if ($NF ~ "^[a-zA-Z].*[0-9]$" && $NF !~ "c[0-9]+d[0-9]+$" && $NF !~ "^loop.*") print "/dev/"$NF}'  /proc/partitions

#�鿴2��100��������
for num in `seq 2 100`;do if [ `factor $num|awk '{print $2}'` == $num ];then echo -n "$num ";fi done;echo

#�鿴��3����6��
awk 'NR >= 3 && NR <= 6' /path/to/file

#����鿴�ļ�
awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'

#��ӡ99�˷���
seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}'
