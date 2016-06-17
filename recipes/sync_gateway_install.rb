#
# Cookbook Name:: couchbase
# Recipe:: sync_gateway_install
#

version      = node['couchbase']['sync_gateway']['version']
edition      = node['couchbase']['sync_gateway']['edition']
release_id   = node['couchbase']['sync_gateway']['release_id']
service_name = node['couchbase']['sync_gateway']['service']

couchbase_sync_gateway 'self' do
    version    version
    edition    edition
    release_id release_id
    action     :install
end

service "#{service_name}" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action   :nothing
end

template "/etc/init.d/#{service_name}" do
    source   'sync_gateway.init.d.erb'
    owner    "root"
    group    "root"
    mode     "0755"
    action   :create
    notifies :enable, "service[#{service_name}]", :immediately
    notifies :restart, "service[#{service_name}]", :immediately
end

directory "#{node[:couchbase][:sync_gateway][:install_dir]}/etc" do
  owner 'couchbase'
  group 'couchbase'
  mode 0755
  recursive true
end