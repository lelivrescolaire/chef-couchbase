unless node['couchbase']['backup']['s3']['bucket_name'].nil? || node['couchbase']['backup']['s3']['region'].nil?
    file = "/tmp/$(date +\\\%Y-\\\%m-\\\%d_\\\%H-\\\%M)"

    cbBackupCommand = "#{node[:couchbase][:server][:paths][:root]}/bin/cbbackup -u #{node[:couchbase][:username]} -p #{node[:couchbase][:password]} --single-node"
    cbBackupCommand = "#{cbBackupCommand} http://localhost:#{node[:couchbase][:port]}"
    cbBackupCommand = "#{cbBackupCommand} #{file}"

    zipCommand = "zip -r #{file}.zip #{file}"

    awsCommand = "aws s3 mv --region=#{node[:couchbase][:backup][:s3][:region]}"
    awsCommand = "#{awsCommand} #{file}.zip"
    awsCommand = "#{awsCommand} s3://#{node[:couchbase][:backup][:s3][:bucket_name]}#{node[:couchbase][:backup][:s3][:path]}/#{node[:opsworks][:instance][:hostname]}/$(date +\\\%Y)/$(date +\\\%m)/$(date +\\\%d)/$(date +\\\%H\\\%M).zip"

    cleanCommand = "rm -rf #{file} #{file}.zip"

    node.override['couchbase']['backup']['command'] = "#{cbBackupCommand} && #{zipCommand} && #{awsCommand} && #{cleanCommand}"

    include_recipe "couchbase::cb_backup"
end