#
# Cookbook Name:: couchbase
# Recipe:: sync_gateway_install
#

version      = node['couchbase']['sync_gateway']['version']
edition      = node['couchbase']['sync_gateway']['edition']
release_id   = node['couchbase']['sync_gateway']['release_id']
service_name = node['couchbase']['sync_gateway']['service']
install_dir  = node['couchbase']['sync_gateway']['paths']['root']
log_dir      = node['couchbase']['sync_gateway']['paths']['logs']

couchbase_sync_gateway 'self' do
    version    version
    edition    edition
    release_id release_id
    action     :install
end

if service_name != "sync_gateway"
  service "sync_gateway" do
    provider Chef::Provider::Service::Upstart
    supports :restart => true, :start => true, :stop => true, :reload => true
    action   :stop
  end

  service "sync_gateway" do
    provider Chef::Provider::Service::Upstart
    supports :restart => true, :start => true, :stop => true, :reload => true
    action   :disable
  end
end

service "#{service_name}" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true, :reload => true
  action   :enable
end

template "/etc/init/#{service_name}.conf" do
    source   'sync_gateway.init.d.erb'
    owner    "root"
    group    "root"
    mode     "0644"
    action   :create
end

directory "#{install_dir}/etc" do
  owner 'couchbase'
  group 'couchbase'
  mode 0755
  recursive true
end

directory "#{install_dir}/var" do
  owner 'couchbase'
  group 'couchbase'
  mode 0755
  recursive true
end

directory "#{log_dir}" do
  owner 'couchbase'
  group 'couchbase'
  mode 0755
  recursive true
end