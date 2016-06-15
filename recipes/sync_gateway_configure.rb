#
# Cookbook Name:: couchbase
# Recipe:: sync_gateway_configure
#

install_dir  = node['couchbase']['sync_gateway']['paths']['root']
service_name = node['couchbase']['sync_gateway']['service']
config       = node['couchbase']['sync_gateway']['config']['data']

if node['couchbase']['sync_gateway']['config']['multiple']
    key    = node['couchbase']['sync_gateway']['config']['key']
    config = config[key]
end

service "#{service_name}" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action   :nothing
end

directory "#{install_dir}/etc" do
  owner     'couchbase'
  group     'couchbase'
  mode      0755
  recursive true
end

template "#{install_dir}/etc/config.json" do
    source    'sync_gateway.config_json.erb'
    variables :config => Chef::JSONCompat.to_json_pretty(config)
    action    :create
    notifies  :restart, "service[#{service_name}]"
end
