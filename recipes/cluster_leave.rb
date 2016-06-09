#
# Cookbook Name:: couchbase
# Recipe:: cluster_leave
#

local_ip_address = node['ipaddress']

username     = node['couchbase']['username']
password     = node['couchbase']['password']
install_path = node['couchbase']['server']['paths']['root']

couchbase_cluster "#{cluster_name}" do
    ip           node['ipaddress']
    port         node['couchbase']['port']
    username     node['couchbase']['username']
    password     node['couchbase']['password']
    install_path install_path
    action       :leave
end