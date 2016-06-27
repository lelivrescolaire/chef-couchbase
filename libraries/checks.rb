def check_cluster(username, password, ip = '127.0.0.1:8091', port = nil)
  hostname = "#{ip}";
  hostname = "#{hostname}:#{port}" unless port.nil?

  uri = URI("http://#{hostname}/pools/default")
  check = Net::HTTP::Get.new(uri)
  check.basic_auth username, password
  res = Net::HTTP.start(uri.hostname, uri.port, :open_timeout => 10) { |http| http.request(check) }
  Chef::Log.info("Check cluster at '#{uri}' response ' #{res.code}'")
  if res.code == '200'
    return true
  else
    return false
  end
end

def check_bucket(username, password, bucket, port = nil)
  hostname = "127.0.0.1";
  hostname = "#{hostname}:#{port}" unless port.nil?
  hostname = "#{hostname}:8091" if port.nil?

  uri = URI("http://#{hostname}/pools/default/buckets/#{bucket}")
  check = Net::HTTP::Get.new(uri)
  check.basic_auth username, password
  res = Net::HTTP.start(uri.hostname, uri.port, :open_timeout => 10) { |http| http.request(check) }
  Chef::Log.warn("res code is #{res.code}")
  if res.code == '200'
    return true
  else
    return false
  end
end

def get_node_info(username, password, ip = '127.0.0.1:8091', port = nil)
  hostname = "#{ip}";
  hostname = "#{hostname}:#{port}" unless port.nil?

  uri = URI("http://#{hostname}/pools/default")
  check = Net::HTTP::Get.new(uri)
  check.basic_auth username, password
  res = Net::HTTP.start(uri.hostname, uri.port, :open_timeout => 10) { |http| http.request(check) }
  Chef::Log.warn("res code is #{res.code}")
  return unless res.code == '200'
  JSON.parse(res.body)
end

def check_in_cluster(username, password, ip, cluster_ip, port = nil)
  infos = get_node_info(username, password, cluster_ip, port)

  return false unless infos.nil?

  hostname = "#{ip}";
  hostname = "#{hostname}:#{port}" unless port.nil?

  Chef::Log.info("Looking for node #{hostname} in the cluster")

  i = infos['nodes'].index { |node| node["hostname"] == hostname }

  Chef::Log.info("Node index is #{i}")

  unless i.nil?
    return true
  end

  return false
end