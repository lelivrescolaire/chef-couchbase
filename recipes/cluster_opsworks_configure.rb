#
# Cookbook Name:: couchbase
# Recipe:: cluster_opsworks_configure
#

username      = node['couchbase']['username']
password      = node['couchbase']['password']
port          = node['couchbase']['port']
clusters      = node['couchbase']['opsworks']['clusters']

layers        = node['opsworks']['layers']
instance      = node['opsworks']['instance']

Chef::Log.info "Current opsworks instance is '#{instance[:hostname]}'"

local_ip_address = instance['private_ip']

Chef::Log.info "Current opsworks instance ip is '#{instance[:private_ip]}'"
Chef::Log.info "Current opsworks instance has #{instance[:layers].length} layer(s)"

cluster_layers = clusters & instance['layers']

Chef::Log.info "Current opsworks instance has #{instance[:layers].length} cluster layer(s)"

unless cluster_layers.empty?
    layer_name    = cluster_layers.first

    Chef::Log.info "Select '#{layer_name}' as cluster layer"

    layer         = layers[layer_name]
    instances     = layer['instances']

    Chef::Log.info "Layer '#{layer_name}' has #{instances.length} instance(s)"

    instances.each do |k, i|
        if i['status'] == 'online'
            Chef::Log.info "Instance '#{k}'(#{i[:private_ip]}) is 'online'"
        end

        if check_cluster(username, password, "#{i[:private_ip]}:#{port}")
            Chef::Log.info "Instance '#{k}'(#{i[:private_ip]}) is a cluster"
        end
    end

    instances_on  = instances.select{|k, i|
                        Chef::Log.info "Filtering '#{i[:private_ip]}'"
                        i['private_ip'] != local_ip_address && i['status'] == 'online' && check_cluster(username, password, i['private_ip'])
                    }

    instances_on = instances_on.values

    Chef::Log.info "Cluster '#{layer_name}' has #{instances_on.length} online node(s)"

    node.override['ipaddress'] = local_ip_address

    unless instances_on.empty?
        Chef::Log.info "Overriding attributes to use '#{layer_name}' layer as cluster reference."

        node.override['couchbase']['cluster']['ip'] = instances_on.first['private_ip']
    end

    include_recipe "couchbase::cluster_configure"
else
    Chef::Log.warn "Abording cluster configuration as no instance's layer were defined as cluster."
end