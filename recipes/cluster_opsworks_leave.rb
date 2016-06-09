#
# Cookbook Name:: couchbase
# Recipe:: cluster_opsworks_leave
#

node.override['ipaddress'] = node['opsworks']['instance']['private_ip']

include_recipe "couchbase::cluster_leave"