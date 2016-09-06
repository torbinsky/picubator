package 'upstart'

# Install picubator upstart service
template "/etc/init/picubator.conf" do
  source "upstart.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

# Start the picubator service
service 'picubator' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :restart => true, :stop => true
  action [ :enable, :start ]
end
