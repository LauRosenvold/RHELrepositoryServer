#!/bin/bash

useradd localadm

passwd localadm

vi /etc/sudoers
#localadm ALL=(ALL) ALL

mount /dev/cdrom /mnt

mkdir /local_repo

touch /etc/yum.repos.d/local-dvdrom.repo

chmod  u+rw,g+r,o+r  /etc/yum.repos.d/local-dvdrom.repo

cd /mnt

tar cvf - . | (cd /local_repo/; tar xvf -)

vi /etc/yum.repos.d/local-dvdrom.repo

[LocalRepo_BaseOS]
name=LocalRepo_BaseOS
metadata_expire=-1
enabled=1
gpgcheck=1
baseurl=file:///local_repo/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[LocalRepo_AppStream]
name=LocalRepo_AppStream
metadata_expire=-1
enabled=1
gpgcheck=1
baseurl=file:///local_repo/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

yum repolist

yum install createrepo yum-utils

createrepo /local_repo/

yum clean all

yum repolist

ls /local_repo/repodata/

yum install httpd

systemctl start httpd

systemctl enable httpd

systemctl status httpd

firewall-cmd --zone=public --permanent --add-service=http

firewall-cmd --zone=public --permanent --add-service=https

firewall-cmd --reload

vi /etc/httpd/conf/httpd.conf

DocumentRoot "/local_repo"

<Directory "/local_repo">

systemctl start httpd

systemctl status httpd

rm -rf /etc/httpd/conf.d/welcome.conf

setfacl -R -m u:apache:rwx /local_repo/

systemctl restart httpd

setenforce 0

/etc/selinux/config
disabled

reboot


#move /local_repo to local_repo/rhel




