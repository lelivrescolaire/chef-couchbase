default['couchbase']['sync_gateway']['edition']    = 'community'
default['couchbase']['sync_gateway']['version']    = '1.2.1'
default['couchbase']['sync_gateway']['release_id'] = 4

default['couchbase']['sync_gateway']['service']       = 'sync_gateway'
default['couchbase']['sync_gateway']['paths']['root'] = '/opt/couchbase-sync-gateway'
default['couchbase']['sync_gateway']['paths']['logs'] = File.join(node['couchbase']['sync_gateway']['install_dir'], 'var', 'logs')

default['couchbase']['sync_gateway']['config']['data']     = {}
default['couchbase']['sync_gateway']['config']['multiple'] = false
default['couchbase']['sync_gateway']['config']['key']      = nil