#
# Cookbook Name:: couchbase
# Resource:: sync_gateway
#

actions :install

attribute :version,    :kind_of => String,  :default => '1.2.1'
attribute :edition,    :kind_of => String,  :default => 'community'
attribute :release_id, :kind_of => Integer, :défault => 4

def initialize(*args)
  super
  @action = :install
end
