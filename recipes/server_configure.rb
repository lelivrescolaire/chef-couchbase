#
# Cookbook Name:: couchbase
# Recipe:: server_configure
#

username      = node['couchbase']['username']
password      = node['couchbase']['password']
port          = node['couchbase']['port']
install_path  = node['couchbase']['server']['paths']['root']
database_path = node['couchbase']['server']['paths']['data']
index_path    = node['couchbase']['server']['paths']['index']

couchbase_server 'self' do
  data_path     data_path
  index_path    index_path
  username      username
  password      password
  install_path  install_path
  port          port
  action        :setup
end