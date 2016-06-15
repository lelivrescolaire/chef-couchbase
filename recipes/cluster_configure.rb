#
# Cookbook Name:: couchbase
# Recipe:: cluster_configure
#

install_path = node['couchbase']['server']['paths']['root']

unless node[:couchbase][:cluster][:ip].nil?
    Chef::Log.info "Using node '#{node[:couchbase][:cluster][:ip]}' as cluster master."

    couchbase_cluster "default" do
        ip           node['ipaddress']
        cluster_ip   node['couchbase']['cluster']['ip']
        username     username
        password     password
        services     node['couchbase']['cluster']['services']
        port         node['couchbase']['port']
        install_path install_path
        action       :join
    end
else
    Chef::Log.info "Initializing a new cluster as no cluster were provided."

    couchbase_cluster "default" do
        username      username
        password      password
        ramsize       node['couchbase']['cluster']['ramsize']['cluster']
        index_ramsize node['couchbase']['cluster']['ramsize']['index']
        services      node['couchbase']['cluster']['services']
        install_path  install_path
        port          node['couchbase']['port']
        action        :init
    end
end
