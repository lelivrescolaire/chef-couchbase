#
# Cookbook Name:: couchbase
# Recipe:: bucket_configure
#

common = {
    "install_path"     => node['couchbase']['server']['paths']['root']
    "cluster_username" => node['couchbase']['username']
    "cluster_password" => node['couchbase']['password']
    "cluster_port"     => node['couchbase']['port']
    "action"           => :create
}

node['couchbase']['bucket'].each do |key, config|
    conf = {}
    conf.merge(common)
    conf.merge({
        "name"            => key
        "type"            => config['type']
        "ramsize"         => config['ramsize']
        "replica"         => config['replica']
        "priority"        => config['priority']
        "password"        => config['password']
        "eviction_policy" => config['eviction_policy']
        "port"            => config['port']
        "flush"           => config['flush']
        "index_replica"   => config['index_replica']
        "priority"        => config['priority']
    })

    Chef::Resource::CouchbaseBucket.new key, conf
end