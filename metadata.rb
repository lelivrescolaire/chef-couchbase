name             'couchbase'
description      'Installs/Configures Couchbase & Sync Gateway'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w(debian ubuntu).each do |os|
  supports os
end

%w(apt).each do |d|
  depends d
end

# Couchbase Server

recipe 'couchbase::server_install', 'Install couchbase server'
recipe 'couchbase::server_configure', 'Configure couchbase server'

# Cluster

recipe 'couchbase::cluster_opsworks_configure', 'Configure a cluster inside AWS OpsWorks'
recipe 'couchbase::cluster_opsworks_leave', 'Leave a couchbase cluster inside AWS opsworks'

# Sync Gateway

recipe 'couchbase::sync_gateway_install', 'Install sync gateway on the node'
recipe 'couchbase::sync_gateway_configure', 'Configure sync gateway on the node'
recipe 'couchbase::sync_gateway_opsworks_configure', 'Configure sync gateway inside AWS OpsWorks'