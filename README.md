# Couchebase & Sync Gateway Cookbook (Chef)

## Features

* Install / Configure Couchbase Server
* Install / Configure Sync Gateway
* Run Sync Gateway as a service
* Write Sync Gateway config file from attributes and use it in the service
* Handle clusters (Couchbase Server + Sync Gateway)
* Automate discovery on AWS Opsworks (using layers) allowing to create multiple cluster in the same stack

## Requirements

* OS: Debian / Ubuntu
* Chef: < 12

## Recipes

### Couchbase Server

* `couchbase::server_install`: Install couchbase server
    * Install package
    * Create directories
* `couchbase::server_configure`: Configure couchbase server

### Cluster

* `couchbase::cluster_configure`: Configure a couchbase server cluster
    * Join an existing cluster if provided *(with attribute `node[:couchbase][:cluster][:ip]`)*
    * Create a new cluster otherwise
* `couchbase::cluster_leave`: Leave current cluster

### Sync Gateway

* `couchbase::sync_gateway_install`: Install sync gateway on the node
    * Install package
    * Create directories
    * Create service
* `couchbase::sync_gateway_configure`: Configure sync gateway on the node
    * Create config file from attributes

### AWS Opsworks specific

* `couchbase::cluster_opsworks_configure`: Configure a cluster inside AWS OpsWorks
    * Match instance layer which is registered in `node[:couchbase][:opsworks][:clusters]` *(if many layers matches, the first in the list is selected)*
    * Look for first `online` instances in the layer that expose a cluster
    * Overrides `node[:couchbase][:cluster][:ip]` with matched instance's ip address
    * Call `couchbase::cluster_configure` recipe *(Only if any of instance's layers was defined as cluster)*
* `couchbase::cluster_opsworks_leave`: Leave a couchbase cluster inside AWS opsworks
    * Overrides `ipaddress` attribute with private ip address
    * Call `couchbase::cluster_leave` recipe
* `couchbase::sync_gateway_opsworks_configure`: Configure sync gateway inside AWS OpsWorks
    * Match instance layer which is registered in `node[:couchbase][:opsworks][:clusters]` *(if many layers matches, the first in the list is selected)*
    * Overrides `couchbase.sync_gateway.config_key` with matched layer name *(Allowing to handle a per layer configuration)*
    * Call `couchbase::sync_gateway_configure` recipe *(Only if any of instance's layers was defined as cluster)*

## Attributes

### Common

Name                          | Allowed Value | Default         | Description
----------------------------- | ------------- | --------------- | --------------------------------------------------------------------
`node[:couchbase][:username]` | *String*      | `Administrator` | Username for every interfaces and APIs (Server, SyncGateway, etc...)
`node[:couchbase][:password]` | *String*      | `password`      | Password for every interfaces and APIs (Server, SyncGateway, etc...)
`node[:couchbase][:port]`     | *Integer*     | `8091`          | Couchbase HTTP port to use (Server & Cluster)

### Couchbase Server

Name                                        | Allowed Value            | Default                                               | Description
------------------------------------------- | ------------------------ | ----------------------------------------------------- | -----------------------------------
`node[:couchbase][:server][:edition]`       | `community` `enterprise` | `community`                                           | Couchbase server edition to install
`node[:couchbase][:server][:version]`       | `[0-9]+.[0-9]+.[0-9]+`   | `4.0.0`                                               | Couchbase server version to install
`node[:couchbase][:server][:service]`       | *String*                 | `couchbase-server`                                    | Couchbase server service name
`node[:couchbase][:server][:paths][:root]`  | *String*                 | `/opt/couchbase`                                      | Couchbase server root path
`node[:couchbase][:server][:paths][:data]`  | *String*                 | `node[:couchbase][:server][:paths][:root]``/var/data` | Couchbase server database path
`node[:couchbase][:server][:paths][:index]` | *String*                 | `node[:couchbase][:server][:paths][:root]``/var/data` | Couchbase server index path
`node[:couchbase][:server][:paths][:logs]`  | *String*                 | `node[:couchbase][:server][:paths][:root]``/var/logs` | Couchbase server logs path

### Cluster

Name                                             | Allowed Value           | Default                    | Description
------------------------------------------------ | ----------------------- | -------------------------- | --------------------------------------------------
`node[:couchbase][:cluster][:ramsize][:cluster]` | *Integer* *(Megabytes)* | 4000                       | Couchbase cluster allowed ram size
`node[:couchbase][:cluster][:ramsize][:index]`   | *Integer* *(Megabytes)* | 256                        | Couchbase cluster index allowed ram size
`node[:couchbase][:cluster][:services]`          | *Array\<String\>*       | `['data','query','index']` | Couchbase cluster's services
`node[:couchbase][:cluster][:ip]`                | *String*                | *Nil*                      | IP Address of an online node in the target cluster

### Sync Gateway

Name                                                  | Allowed Value            | Default                                                     | Description
----------------------------------------------------- | ------------------------ | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------
`node[:couchbase][:sync_gateway][:edition]`           | `community` `enterprise` | `community`                                                 | Sync Gateway edition to install
`node[:couchbase][:sync_gateway][:version]`           | `[0-9]+.[0-9]+.[0-9]+`   | `1.2.1`                                                     | Sync Gateway version to install
`node[:couchbase][:sync_gateway][:release_id]`        | *Integer*                | `4`                                                         | Sync Gateway release id *(Follows the version in in the download URL > 1.0.3)*
`node[:couchbase][:sync_gateway][:service]`           | *String*                 | `sync_gateway`                                              | Sync Gateway service name
`node[:couchbase][:sync_gateway][:paths][:root]`      | *String*                 | `/opt/couchbase-sync-gateway`                               | Sync Gateway root path
`node[:couchbase][:sync_gateway][:paths][:logs]`      | *String*                 | `node[:couchbase][:sync_gateway][:paths][:root]``/var/logs` | Sync Gateway logs path
`node[:couchbase][:sync_gateway][:config][:data]`     | *Hash*                   | `{}`                                                        | Sync Gateway config to be pushed in the config file
`node[:couchbase][:sync_gateway][:config][:multiple]` | *Boolean*                | `false`                                                     | Whether or not `node[:couchbase][:sync_gateway][:config][:data]` in embedding multiple configurations (e.g multiple clusters with different configurations)
`node[:couchbase][:sync_gateway][:config][:key]`      | *String*                 | *Nil*                                                       | Current node configuration key ( if `node[:couchbase][:sync_gateway][:config][:multiple]` is set to `true`)

## AWS Opsworks specific

Name                                     | Allowed Value     | Default  | Description
---------------------------------------- | ----------------- | -------- | -------------------------------------------------------------------------------
`node[:couchbase][:opsworks][:clusters]` | *Array\<String\>* | `[]`     | Opsworks layers to be used as couchbase clusters (For instances auto detection)

## Roadmap

* XDCR recipes
* Moxi Recipes
* More plateform supports
* Use Chef `search` to make it works on Chef 12