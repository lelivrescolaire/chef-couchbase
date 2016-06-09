default['couchbase']['server']['edition'] = 'community'
default['couchbase']['server']['version'] = '4.0.0'

default['couchbase']['server']['service'] = 'couchbase-server'

default['couchbase']['server']['paths']['root']  = '/opt/couchbase'
default['couchbase']['server']['paths']['data']  = File.join(node['couchbase']['server']['paths']['root'], 'var', 'data')
default['couchbase']['server']['paths']['index'] = File.join(node['couchbase']['server']['paths']['root'], 'var', 'data')
default['couchbase']['server']['paths']['logs']  = File.join(node['couchbase']['server']['paths']['root'], 'var', 'logs')
