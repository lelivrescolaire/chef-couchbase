#
# Cookbook Name:: couchbase
# Resource:: server
#

actions :install, :setup

attribute :version,      :kind_of => String, :default => '4.0.0'
attribute :edition,      :kind_of => String, :default => 'community'
attribute :install_path, :kind_of => String
attribute :data_path,    :kind_of => String
attribute :index_path,   :kind_of => String
attribute :username,     :kind_of => String
attribute :password,     :kind_of => String
attribute :port,         :kind_of => Integer, :default => 8091

def initialize(*args)
  super
  @action = :install
end
