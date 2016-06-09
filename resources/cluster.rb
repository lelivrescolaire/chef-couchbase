#
# Cookbook Name:: couchbase
# Resource:: cluster
#

actions :init, :join, :leave, :rebalance

attribute :services,      :kind_of => Array,  :default => ['data','index','query']
attribute :ramsize,       :kind_of => Integer
attribute :index_ramsize, :kind_of => Integer
attribute :username,      :kind_of => String
attribute :password,      :kind_of => String
attribute :install_path,  :kind_of => String, :default => '/opt/couchbase'
attribute :cluster_ip,    :kind_of => String
attribute :port,          :kind_of => Integer, :default => 8091
attribute :ip,            :kind_of => String

def initialize(*args)
  super
  @action = :init
end
