# Install Git
package "git"
# Support for building Adafruit DHT library
package "build-essential"
# For requests[security]
package "libffi-dev"
package "libssl-dev"

# Install python and pythong packages that we will need
python_runtime "2"
# For controlling GPIO on Raspberry Pi (TODO: support BBB?)
python_package 'RPi.GPIO'
# Adafruit IO
python_package 'adafruit-io'
# Need better SSL!
python_package 'requests[security]'
python_package 'transitions'
python_package 'picamera'

Chef::Log.info("Downloading Adafruit Python DHT library...")

# Download Adafruit Python DHT Sensor Library
git "#{Chef::Config[:file_cache_path]}/dht22" do
  repository 'git://github.com/adafruit/Adafruit_Python_DHT.git'
  reference 'master'
  group 'root'
  user 'root'
  action :sync
end

Chef::Log.info("Installing Adafruit Python DHT library...")

# Build and install the DHT22 sensor library
bash 'install_dht22_build' do
  cwd "#{Chef::Config[:file_cache_path]}/dht22"
  code <<-EOH
    sudo python ./setup.py install --force-#{node['dht']['platform']}
    EOH
  environment 'PREFIX' => '/usr/local'
end

# Setup application root directory
directory node['picubator']['app_root'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

Chef::Log.info("Downloading picubator-app...")

# Download picubator-app to app root directory
git "#{node['picubator']['app_root']}" do
  repository 'git://github.com/torbinsky/picubator-app.git'
  reference 'master'
  action :sync
  notifies :restart, 'service[picubator]'
end

# Ensure permissions are correct
directory "#{node['picubator']['app_root']}" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

Chef::Log.info("Installing picubator-app...")

# Setup config directory
directory node['picubator']['config_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

# Set config for picubator
template "#{node['picubator']['config_dir']}config.json" do
  source "config.json.erb"
  owner "root"
  group "root"
  mode '0700'
  notifies :restart, 'service[picubator]'
end
