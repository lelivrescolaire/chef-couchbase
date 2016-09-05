#
# Cookbook Name:: couchbase
# Recipe:: sync_gateway_configure
#

service_name = node['couchbase']['sync_gateway']['service']

service "#{service_name}" do
  provider Chef::Provider::Service::Init
  supports :restart => true, :start => true, :stop => true, :reload => true
  action   :start
end