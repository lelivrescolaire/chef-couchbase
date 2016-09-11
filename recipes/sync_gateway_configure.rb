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

execute "restart_#{service_name}" do
  command "service #{service_name} restart"
  action :nothing
end

template "#{install_dir}/etc/config.json" do
    source    'sync_gateway.config_json.erb'
    variables :config => Chef::JSONCompat.to_json_pretty(config)
    action    :create
    notifies :run, "execute[restart_#{service_name}]", :immediately
end
