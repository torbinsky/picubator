# Install Git
package "git"
# Support for building Adafruit DHT library
package "build-essential"
# For requests[security]
package "libffi-dev"
package "libssl-dev"

# Install python and pythong packages that we will need
python_runtime "2"
# For our picubator daemon
python_package 'daemon'
# Adafruit IO
python_package 'adafruit-io'
# Need better SSL!
python_package 'requests[security]'

# Download Adafruit Python DHT Sensor Library
git "#{Chef::Config[:file_cache_path]}/dht22" do
  repository 'git://github.com/adafruit/Adafruit_Python_DHT.git'
  reference 'master'
  action :sync
end

# Build and install the DHT22 sensor library
bash 'install_dht22_build' do
  cwd "#{Chef::Config[:file_cache_path]}/dht22"
  code <<-EOH
    sudo python ./setup.py install --force-#{node['dht']['platform']}
    EOH
  environment 'PREFIX' => '/usr/local'
end
