#
# Cookbook Name:: couchbase
# Provider:: server
#

use_inline_resources

def command(action, ip="127.0.0.1")
  cmd = couchbase_cli_command(action, new_resource.install_path)
  cmd = couchbase_cli_cluster(cmd, ip, new_resource.port, new_resource.username, new_resource.password)

  return cmd
end

action :install do
    arch         = "amd64" #node['kernel']['machine']
    os_version   = "#{node[:platform]}#{node[:platform_version]}"

    package_file = "couchbase-server-#{new_resource.edition}_#{new_resource.version}-#{os_version}_#{arch}.deb"
    url_base     = "http://packages.couchbase.com/releases/#{new_resource.version}"

    package_full_url = "#{url_base}/#{package_file}"
    package_path = "#{Chef::Config[:file_cache_path]}/#{package_file}"

    Chef::Log.warn("package file is #{package_full_url}")

    remote_file package_path do
        source package_full_url
        action :create_if_missing
    end

    dpkg_package package_path
end

action :setup do
  if check_cluster(new_resource.username, new_resource.password) == false
    cmd = command('node-init')
    cmd = couchbase_cli_node_init_data_path(cmd, new_resource.data_path)
    cmd = couchbase_cli_node_init_index_path(cmd, new_resource.index_path)

    execute 'setting up server with #{cmd}' do
      command cmd
    end
  end
end
