# Install python package required by systemd daemon
python_package 'sdnotify'

# Install the systemd service unit
systemd_service 'picubator' do
  description 'Service for controlling/monitoring an incubator using a Raspberry Pi'
  after %w( network-online.target )
  wants %w( network-online.target )
  install do
    wanted_by 'multi-user.target'
  end
  service do
    environment 'PICUBATOR_CONFIG' => "#{node['picubator']['config_dir']}/config.json"
    case node['picubator']['noop_daemon']
    when "ON"
      exec_start "/usr/bin/python #{node['picubator']['app_root']}/picubator/systemd.py noop"
    when "OFF"
      exec_start "/usr/bin/python #{node['picubator']['app_root']}/picubator/systemd.py"
    end
    type 'notify'
    restart 'on-failure'
  end
  only_if { ::File.open('/proc/1/comm').gets.chomp == 'systemd' } # systemd
end

# Start the picubator service
service 'picubator' do
  provider Chef::Provider::Service::Systemd
  supports :start => true, :restart => true, :stop => true, :status => true
  action [ :enable, :start ]
end
