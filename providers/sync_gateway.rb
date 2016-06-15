#
# Cookbook Name:: couchbase
# Provider:: sync_gateway
#

use_inline_resources

action :install do
    arch = node['kernel']['machine']
    id   = ""
    id   = "-#{new_resource.release_id}" unless new_resource.release_id.nil?

    package_file = "couchbase-sync-gateway-#{new_resource.edition}_#{new_resource.version}#{id}_#{arch}.deb"
    url_base     = "http://packages.couchbase.com/releases/couchbase-sync-gateway/#{new_resource.version}"

    package_full_url = "#{url_base}/#{package_file}"
    package_path = "#{Chef::Config[:file_cache_path]}/#{package_file}"

    Chef::Log.warn("package file is #{package_full_url}")

    remote_file package_path do
        source package_full_url
        action :create_if_missing
    end

    dpkg_package package
end
