unless node['couchbase']['backup']['s3']['bucket_name'].nil? || node['couchbase']['backup']['s3']['region'].nil?
    file = "/tmp/$(date +%Y-%m-%d_%H-%M)"

    cbBackupCommand = "/opt/couchbase/bin/cbbackup -u #{node[:couchbase][:username]} -p #{node[:couchbase][:password]} --single-node"
    cbBackupCommand = "http://localhost:#{node[:couchbase][:port]}"
    cbBackupCommand = "/tmp/$(date +%Y-%m-%d_%H-%M)"

    zipCommand = "zip -r #{file}.zip #{file}"

    awsCommand = "aws s3 mv --region=#{node[:couchbase][:backup][:s3][:region]}"
    awsCommand = "#{command} #{file}.zip"
    awsCommand = "#{command} s3://#{node[:couchbase][:backup][:s3][:bucket_name]}#{node[:couchbase][:backup][:s3][:path]}/$(date +%Y)/$(date +%m)/$(date +%d)/$(date +%H%M).zip"

    node.override['couchbase']['backup']['command'] = "#{cbBackupCommand} && #{zipCommand} && #{awsCommand}"

    include_recipe "couchbase::cb_backup"
end