#
# Cookbook Name:: couchbase
# Provider:: bucket
#

use_inline_resources

def command(action)
  cmd = couchbase_cli_command(action, new_resource.install_path)
  cmd = couchbase_cli_cluster(cmd, '127.0.0.1', new_resource.cluster_port, new_resource.cluster_username, new_resource.cluster_password)
  cmd = couchbase_cli_bucket(cmd, new_resource.name)

  return cmd
end

def create_or_edit(allowEdit = true)
  action = 'bucket-create'
  action = 'bucket-edit'   if check_bucket(new_resource.cluster_username, new_resource.cluster_password, new_resource.name)

  if (action != 'bucket-edit' || allowEdit)
    cmd = command(action)
    cmd = couchbase_cli_bucket_eviction_policy(cmd, new_resource.eviction_policy)
    cmd = couchbase_cli_bucket_type(cmd, new_resource.type)
    cmd = couchbase_cli_bucket_port(cmd, new_resource.port)
    cmd = couchbase_cli_bucket_ramsize(cmd, new_resource.ramsize) unless new_resource.ramsize.nil?
    cmd = couchbase_cli_bucket_priority(cmd, new_resource.priority)
    cmd = couchbase_cli_bucket_replica(cmd, new_resource.replica)
    cmd = couchbase_cli_enable_flush(cmd, new_resource.bucket_flush)
    cmd = couchbase_cli_bucket_password(cmd, new_resource.password)
    cmd = couchbase_cli_enable_index_replica(cmd, new_resource.index_replica)

    execute "executing #{action}" do
      command cmd
    end
  end
end

action :create do
  create_or_edit
end

action :create_if_not_exists do
  create_or_edit(false)
end

action :delete do
  if check_bucket(new_resource.username, new_resource.password, new_resource.bucket_name)
    action = 'bucket-delete'
    cmd    = command(action)

    execute "executing #{action}" do
      command cmd
    end
  end
end
