#
# Cookbook Name:: couchbase
# Provider:: cluster
#

use_inline_resources

def command(action, ip="127.0.0.1")
  cmd = couchbase_cli_command(action, new_resource.install_path)
  cmd = couchbase_cli_cluster(cmd, ip, new_resource.port, new_resource.username, new_resource.password)

  return cmd
end

action :rebalance do
  if check_in_cluster(new_resource.username, new_resource.password, "#{new_resource.cluster_ip}:#{new_resource.port}")

    cmd = command('rebalance', new_resource.cluster_ip)

    execute "rebalancing cluster with #{cmd}" do
      command cmd
    end
  end
end

action :init do
  unless check_cluster(new_resource.username, new_resource.password, "127.0.0.1:#{new_resource.port}")
    cmd = command('cluster-init')
    cmd = couchbase_cli_cluster_username(cmd, new_resource.username)
    cmd = couchbase_cli_cluster_password(cmd, new_resource.password)
    cmd = couchbase_cli_cluster_ramsize(cmd, new_resource.ramsize)
    cmd = couchbase_cli_cluster_index_ramsize(cmd, new_resource.index_ramsize)
    cmd = couchbase_cli_services(cmd, new_resource.services)

    execute "cluster init to initialize server with #{cmd}" do
      command cmd
    end
  end
end

action :join do
  Chef::Log.info "Trying to join cluster #{new_resource.cluster_ip}"

  unless check_in_cluster(new_resource.username, new_resource.password, "#{new_resource.cluster_ip}:#{new_resource.port}")
    unless new_resource.ip == new_resource.cluster_ip
      Chef::Log.info "#{new_resource.cluster_ip} is not the current instance"

      cmd = command('server-add', new_resource.cluster_ip)
      cmd = couchbase_cli_server_add(cmd, new_resource.ip, new_resource.port, new_resource.username, new_resource.password)
      cmd = couchbase_cli_services(cmd, new_resource.services)

      execute "joining to cluster with #{cmd}" do
        command cmd
      end

      couchbase_cluster "default" do
        install_path new_resource.install_path
        cluster_ip   new_resource.cluster_ip
        username     new_resource.username
        password     new_resource.password
        action       :rebalance
      end
    end
  else
    Chef::Log.info "Instance is already member of cluster #{new_resource.cluster_ip}"
  end
end

action :leave do
  if check_cluster(new_resource.username, new_resource.password, "127.0.0.1:#{new_resource.port}")
    cmd = command('rebalance', "127.0.0.1")
    cmd = couchbase_cli_server_remove(cmd, new_resource.ip, new_resource.port)

    execute "leaving cluster with #{cmd}" do
      command cmd
    end
  end
end
