#
# Cookbook Name:: couchbase
# Recipe:: bucket_configure
#

node['couchbase']['bucket'].each do |key, config|
    couchbase_bucket "#{key}" do
        name             key
        type             config['type']
        ramsize          config['ramsize']
        replica          config['replica']
        priority         config['priority']
        password         config['password']
        eviction_policy  config['eviction_policy']
        port             config['port']
        flush            config['flush']
        index_replica    config['index_replica']
        priority         config['priority']
        install_path     node['couchbase']['server']['paths']['root']
        cluster_username node['couchbase']['username']
        cluster_password node['couchbase']['password']
        cluster_port     node['couchbase']['port']
        action :create
    end
end