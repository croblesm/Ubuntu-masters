# DEMO 0 - Getting started with MicroK8s
# 
#   1- List multipass instances
#   2- Get micro-k8s vm info
#   3- Get MicroK8s status
#   4- Enable MicroK8s (kubernetes) addons
# -----------------------------------------------------------------------------
# Reference:
#   https://multipass.run
#   https://microk8s.io/docs
#   https://microk8s.io/docs/addons

# 1- Manage Multipass
multipass start
multipass stop

# 2- List multipass instances
multipass list

# 3- Get micro-k8s Ubuntu VM info
multipass info microk8s-vm

# Ubuntu VM specs
# Disk usage:     5.9G out of 48.3G
# Memory usage:   1.8G out of 3.9G

# Note: 
# MicroK8s VM creation (default)
# multipass launch --name microk8s-vm --mem 4G --disk 40G
# multipass exec microk8s-vm -- sudo snap install microk8s --classic
# multipass exec microk8s-vm -- sudo iptables -P FORWARD ACCEPT

# 4- Manage MicroK8s
microk8s start
microk8s stop

# 5- Get MicroK8s status
# Check enabled addons
microk8s status

# Note:
# metallb, ha-cluster, dns & storage are critical for statefull apps (databases) 👀 

# 6- Enable MicroK8s (kubernetes) addons
microk8s enable helm3