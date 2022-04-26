#!/bin/bash
sudo su
yum -y update
yum -y install httpd
yum -y install python-psutil
yum -y install gcc python-devel
yum -y install python-pip


mylocalIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

# echo "<h2>Web Server with IP: $mylocalIP</h2><br>Greetings!" > /var/www/html/index.html

cat <<EOF > /var/www/html/index.html
<html>
<h2>Created by Terraform <font color="purple"> v1.1.4</font></h2><br>

<h2>Web Server with IP: $mylocalIP</h2><br>Greetings,
Owner ${f_name} ${l_name}!<br>

</html>
EOF

sudo service httpd start
chkconfig httpd on


cat <<EOF > /home/ec2-user/python_script.py
import psutil
import time
Twnd = 10
Tsmp = 0.1
N = int(Twnd/Tsmp)
i = 0
net = psutil.net_io_counters(pernic=True)
sent = net['eth0'].bytes_sent
received = net['eth0'].bytes_recv
while i == 0:
    starpiba=[]
    for k in range(N):
        time.sleep(Tsmp) # Sleep for 3 seconds
        net = psutil.net_io_counters(pernic=True)
        sent1 = net['eth0'].bytes_sent
        received2 = net['eth0'].bytes_recv
        starpiba.append(received2-received)
        received = received2
    print(starpiba)
EOF


