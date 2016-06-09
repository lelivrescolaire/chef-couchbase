#
# Cookbook Name:: couchbase
# Recipe:: server_install
#
version = node['couchbase']['server']['version']
edition = node['couchbase']['server']['edition']

log_dir       = node['couchbase']['server']['paths']['logs']
install_dir   = node['couchbase']['server']['paths']['root']
database_path = node['couchbase']['server']['paths']['data']
index_path    = node['couchbase']['server']['paths']['index']

couchbase_server 'self' do
    version version
    edition edition
    action  :install
end

service 'couchbase-server' do
  supports :restart => true, :status => true
  action   [:enable, :start]
end

directory log_dir do
  owner     'couchbase'
  group     'couchbase'
  mode      0755
  recursive true
end

directory database_path do
  owner     'couchbase'
  group     'couchbase'
  mode      0755
  recursive true
end

directory index_path do
  owner     'couchbase'
  group     'couchbase'
  mode      0755
  recursive true
  only_if { database_path != index_path }
end

ruby_block 'rewrite_couchbase_log_dir_config' do
  log_dir_line = %({error_logger_mf_dir, "#{log_dir}"}.)

  block do
    file = Chef::Util::FileEdit.new("#{install_dir}/etc/couchbase/static_config")
    file.search_file_replace_line(/error_logger_mf_dir/, log_dir_line)
    file.write_file
  end

  notifies :restart, 'service[couchbase-server]'
  not_if "grep '#{log_dir_line}' #{install_dir}/etc/couchbase/static_config"
end