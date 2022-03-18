~~~
# 单机
docker-compose up -d && docker-compose logs -f

# 集群
docker-compose -f cluster.yml up -d
~~~

## 备份还原
~~~
docker exec -it mysql mysqldump -uroot -p123456 database > /data/database.sql

docker exec -i mysql mysql -uroot -p123456 database < /data/database.sql
~~~


## 禁止root账号远程登录

~~~
mysql -uroot -p123456 -Dmysql -e "select Host,User,authentication_string from mysql.user;"
mysql -uroot -p123456 -Dmysql -e "DELETE FROM mysql.user WHERE Host='%' AND User='root';"
~~~

## 创建远程数据库并创建授权账号

~~~
# 首先创建一个数据库(zqw)
create database zqw;
mysql -uroot -p123456 -Dmysql -e "create database zqw;"
# 授权zhiqw用户拥有zqw数据库的所有权限，但只能在本地访问。
grant all privileges on zqw.* to 'zqw'@localhost identified by '123456';
mysql -uroot -p123456 -Dmysql -e "grant all privileges on zqw.* to 'zqw'@localhost identified by '123456';"
# 用户可以远程访问zqw数据库 
grant all privileges on zqw.* to 'zqw'@'%' identified by '123456'; 
mysql -uroot -p123456 -Dmysql -e "grant all privileges on zqw.* to 'zqw'@'%' identified by '123456';"
# 刷新系统权限表 
flush privileges;
mysql -uroot -p123456 -Dmysql -e "flush privileges;"
~~~







## 集群数据同步

~~~
# 进入主数据库查看
docker exec -it mysql-master bash
show master status;
File 和 Position 2个参数的值

# 进入从数据库进行配置
docker exec -it mysql-slave-1 bash
stop slave;
CHANGE MASTER TO
    MASTER_HOST='mysql-master',
    MASTER_USER='root',
    MASTER_PASSWORD='123456',
    MASTER_LOG_FILE='mysql-bin.000004',
    MASTER_LOG_POS=154;
start slave;
~~~


