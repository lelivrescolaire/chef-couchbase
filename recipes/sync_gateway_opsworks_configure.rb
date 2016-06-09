if node['couchbase']['sync_gateway']['config']['multiple']
    layers      = node['opsworks']['instance']['layers']
    configNames = node['couchbase']['sync_gateway']['config']['data'].keys

    configs = configNames & layers

    node.default['couchbase']['sync_gateway']['config']['key'] = configs.first
end

include_recipe 'couchbase::sync_gateway_configure'
