def check_cluster(username, password, ip = 'localhost:8091')
  uri = URI("http://#{ip}/pools/default")
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

def check_bucket(username, password, bucket)
  uri = URI("http://localhost:8091/pools/default/buckets/#{bucket}")
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

def get_node_info(username, password, ipaddress)
  uri = URI("http://#{ipaddress}/pools/default")
  check = Net::HTTP::Get.new(uri)
  check.basic_auth username, password
  res = Net::HTTP.start(uri.hostname, uri.port, :open_timeout => 10) { |http| http.request(check) }
  return unless res.code == '200'
  JSON.parse(res.body)
end