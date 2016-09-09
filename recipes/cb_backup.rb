unless node['couchbase']['backup']['command'].nil?
    cron "setup_cb_backup" do
        hour    node['couchbase']['backup']['hour']
        minute  node['couchbase']['backup']['minute']
        day     node['couchbase']['backup']['day']
        weekday node['couchbase']['backup']['weekday']
        month   node['couchbase']['backup']['month']
        command node['couchbase']['backup']['command']
    end
end