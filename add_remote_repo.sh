sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

mkdir /docker_ce_packages

reposync -p /docker_ce_packages --repo=docker-ce-stable --download-metadata

chown apache /docker_ce_packages/
(maybe more needed)

vi /etc/yum.repos.d/docker-ce.repo

[docker-ce-stable]
name=Docker CE Stable - $basearch
enabled=1
gpgcheck=1
baseurl=file:///docker_ce_packages/docker-ce-stable
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release


createrepo /docker_ce_packages/

yum clean all

yum repolist

chown apache /docker_ce_packages/repodata

#move /docker_ce_packages to /local_repo/docker_ce

