unless node['couchbase']['backup']['s3']['bucket_name'].nil? || node['couchbase']['backup']['s3']['region'].nil?
    file = "/tmp/$(date +\\\%Y-\\\%m-\\\%d_\\\%H-\\\%M)"

    variables = "FILE=#{file}"
    variables = "#{variables} S3_FILE=$(date +\\\%Y)/$(date +\\\%m)/$(date +\\\%d)/$(date +\\\%H\\\%M)"

    cbBackupCommand = "#{node[:couchbase][:server][:paths][:root]}/bin/cbbackup -u #{node[:couchbase][:username]} -p #{node[:couchbase][:password]} --single-node"
    cbBackupCommand = "#{cbBackupCommand} http://localhost:#{node[:couchbase][:port]}"
    cbBackupCommand = "#{cbBackupCommand} $FILE"

    zipCommand = "cd $FILE && zip -r $FILE.zip *"

    awsCommand = "aws s3 mv --region=#{node[:couchbase][:backup][:s3][:region]}"
    awsCommand = "#{awsCommand} $FILE.zip"
    awsCommand = "#{awsCommand} s3://#{node[:couchbase][:backup][:s3][:bucket_name]}#{node[:couchbase][:backup][:s3][:path]}/#{node[:opsworks][:instance][:hostname]}/$S3_FILE.zip"

    cleanCommand = "rm -rf $FILE $FILE.zip"

    node.override['couchbase']['backup']['command'] = "#{variables}; #{cbBackupCommand} && #{zipCommand} && #{awsCommand} && #{cleanCommand}"

    include_recipe "couchbase::cb_backup"
end