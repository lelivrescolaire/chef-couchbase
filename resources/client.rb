#
# Cookbook Name:: couchbase
# Resource:: client
#

actions :install

def initialize(*args)
  super
  @action = :install
end
