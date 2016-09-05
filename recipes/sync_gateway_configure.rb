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

template "#{install_dir}/etc/config.json" do
    source    'sync_gateway.config_json.erb'
    variables :config => Chef::JSONCompat.to_json_pretty(config)
    action    :create
end

service "#{service_name}" do
  provider Chef::Provider::Service::Upstart
  action   :restart
end
