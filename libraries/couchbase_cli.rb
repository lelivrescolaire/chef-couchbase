def couchbase_cli_command(action, install_path)
  cmd = "#{install_path}/bin/couchbase-cli #{action}"

  return cmd
end

# -------------------------------------------------
# Common
# -------------------------------------------------

def couchbase_cli_cluster(cmd, ip, port, username, password)
  cmd = "#{cmd} -c #{ip}"
  cmd = "#{cmd}:#{port}" unless port.nil?
  cmd = couchbase_cli_username(cmd, username) unless username.nil?
  cmd = couchbase_cli_password(cmd, password) unless password.nil?

  return cmd
end

def couchbase_cli_username(cmd, username)
  cmd = "#{cmd} -u #{username}" unless username.nil?

  return cmd
end

def couchbase_cli_password(cmd, password)
  cmd = "#{cmd} -p #{password}" unless password.nil?

  return cmd
end

def couchbase_cli_ssl(cmd, enable=true)
  cmd = "#{cmd} --ssl" if enable

  return cmd
end

def couchbase_cli_output(cmd, output)
  cmd = "#{cmd} --output=#{output}"

  return cmd
end

# -------------------------------------------------
# Cluster
# -------------------------------------------------

def couchbase_cli_cluster_username(cmd, username)
  cmd = "#{cmd} --cluster-username=#{username}"

  return cmd
end

def couchbase_cli_cluster_password(cmd, password)
  cmd = "#{cmd} --cluster-password=#{password}"

  return cmd
end

def couchbase_cli_cluster_ramsize(cmd, ramsize)
  cmd = "#{cmd} --cluster-ramsize=#{ramsize}"

  return cmd
end

def couchbase_cli_cluster_index_ramsize(cmd, index_ramsize)
  cmd = "#{cmd} --cluster-index-ramsize=#{index_ramsize}"

  return cmd
end

def couchbase_cli_services(cmd, services)
  services = services.join(',') if services.kind_of?(Array)

  cmd = "#{cmd} --services=#{services}"

  return cmd
end

def couchbase_cli_server_add(cmd, ip, port, username, password)
  cmd = "#{cmd} --server-add=#{ip}"
  cmd = "#{cmd}:#{port}" unless port.nil?
  cmd = couchbase_cli_server_add_username(cmd, username) unless username.nil?
  cmd = couchbase_cli_server_add_password(cmd, password) unless password.nil?

  return cmd
end

def couchbase_cli_server_add_username(cmd, username)
  cmd = "#{cmd} --server-add-username=#{username}"

  return cmd
end

def couchbase_cli_server_add_password(cmd, password)
  cmd = "#{cmd} --server-add-password=#{password}"

  return cmd
end

def couchbase_cli_server_remove(cmd, ip, port)
  cmd = "#{cmd} --server-remove=#{ip}"
  cmd = "#{cmd}:#{port}" unless port.nil?

  return cmd
end

def couchbase_cli_server_failover(cmd, ip, port)
  cmd = "#{cmd} --server-failover=#{ip}"
  cmd = "#{cmd}:#{port}" unless port.nil?

  return cmd
end

# -------------------------------------------------
# Bucket
# -------------------------------------------------

def couchbase_cli_bucket(cmd, name)
  cmd = "#{cmd} --bucket=#{name}"

  return cmd
end

def couchbase_cli_bucket_type(cmd, type)
  cmd = "#{cmd} --bucket-type=#{type}"

  return cmd
end

def couchbase_cli_bucket_port(cmd, port)
  cmd = "#{cmd} --bucket-port=#{port}"

  return cmd
end

def couchbase_cli_bucket_ramsize(cmd, ramsize)
  cmd = "#{cmd} --bucket-ramsize=#{ramsize}"

  return cmd
end

def couchbase_cli_bucket_priority(cmd, priority)
  cmd = "#{cmd} --bucket-priority=#{priority}"

  return cmd
end

def couchbase_cli_bucket_replica(cmd, replica)
  cmd = "#{cmd} --bucket-replica=#{replica}"

  return cmd
end

def couchbase_cli_bucket_password(cmd, password)
  cmd = "#{cmd} --bucket-password=#{password}" unless password.nil?

  return cmd
end

def couchbase_cli_bucket_eviction_policy(cmd, eviction)
  cmd = "#{cmd} --bucket-eviction-policy=#{eviction}"

  return cmd
end

def couchbase_cli_enable_flush(cmd, enable=true)
  cmd = "#{cmd} --enable-flush=1" if enable

  return cmd
end

def couchbase_cli_enable_index_replica(cmd, enable=true)
  cmd = "#{cmd} --enable-index-replica=1" if enable

  return cmd
end

# -------------------------------------------------
# Node
# -------------------------------------------------

def couchbase_cli_node_init_data_path(cmd, path)
  cmd = "#{cmd} --node-init-data-path=#{path}"

  return cmd
end

def couchbase_cli_node_init_index_path(cmd, path)
  cmd = "#{cmd} --node-init-index-path=#{path}"

  return cmd
end

def couchbase_cli_node_init_hostname(cmd, hostname)
  cmd = "#{cmd} --node-init-hostname=#{hostname}"

  return cmd
end