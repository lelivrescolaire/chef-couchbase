#
# Cookbook Name:: couchbase
# Resource:: manage_bucket
#

actions :create, :edit, :delete

attribute :name,             :kind_of => String,                  :name_attribute => true
attribute :type,             :kind_of => String,                  :default => 'couchbase'
attribute :ramsize,          :kind_of => Integer
attribute :replica,          :kind_of => Integer,                 :default => '1'
attribute :priority,         :kind_of => String,                  :default => 'high'
attribute :password,         :kind_of => String,                  :default => nil
attribute :eviction_policy,  :kind_of => String,                  :default => 'valueOnly'
attribute :port,             :kind_of => Integer,                 :default => '11211'
attribute :flush,            :kind_of => [TrueClass, FalseClass], :default => false
attribute :index_replica,    :kind_of => [TrueClass, FalseClass], :default => false
attribute :priority,         :kind_of => String,                  :default => 'low'
attribute :install_path,     :kind_of => String,                  :default => '/opt/couchbase'
attribute :cluster_username, :kind_of => String,                  :default => 'Administrator'
attribute :cluster_password, :kind_of => String,                  :default => 'password'
attribute :cluster_port,     :kind_of => Integer,                 :default => 8091

def initialize(*args)
  super
  @action = :create
end
