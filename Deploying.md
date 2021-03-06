# How to deploy from a linux workstation to a Raspberry Pi

## How to setup Windows Linux Subsystem (Ubuntu 14.04) for deploying to Pi

Basically, install chefdk and install knife-solo using chef gem

1. install chefdk
  * `wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb`
  * `sudo dpkg -i chefdk_0.14.25-1_amd64.deb`
2. install knife-solo
  * `sudo chef gem install knife-solo`

## Use knife-solo to run recipes on our Pi

knife-solo expects that we have a directory structure similar to that generated by `knife solo init .` in the current directory. Most importantly, we want a Berksfile and a site-cookbooks available.

It also seems that knife solo expects rsync to be available on the host OS. This is an issue for Winblows... Argh!

1. execute run_list on Pi
  * `knife solo bootstrap pi@192.168.14.137` (combines prepare/cook in 1 cmd)`

# Setup Chef on Pi

Note: this shouldn't be required if you use the knife-solo bootstrap which sets up chef-solo

Need to install chef on pi (it seems that knife solo prepare is failing). I ran into issues with the latest ruby version available on the pi being ~2.1. This meant that rack/chef have trouble installing. To overcome this, I found I needed to install rack 1.6.4 and then chef-zero 4.9.0. Once that is done, the chef gem will detect those versions and use them instead of trying to use newer versions which aren't available for Ruby 2.1.

This would be a LOT easier with Ruby 2.2+ on the Pi... Possibly consider building Ruby 2.2+ from source and installing that instead.

  1. ssh into pi
  2. `sudo apt-get install ruby`
  3. `sudo gem install --no-ri --no-rdoc rack -v 1.6.4`
  4. `sudo gem install --no-ri --no-rdoc chef-zero -v 4.9.0`
  4. `sudo gem install --no-ri --no-rdoc chef`

# How to setup generic Ruby1.9 for deploying to Pi (Note: stuck on ohai dependency issue)

Notes:
* This doesn't work yet and it's much easier to just install the ChefDK and install knife-solo using the `chef gem`.
* Very similar steps could be followed for newer versions of Ruby. THe main difference is the library versions that you choose to install. Newer versions of Ruby will support newer versions of the dependencies. Ruby 2.2+ should work with simply

I should really figure out how Gem works so I can just do something like set something like the Ruby version compatibility which would get me the latest package that actually supports my ruby version. That way I can stop manually fixing each gem dependency error!

1. install ruby and ruby-dev
  * `sudo apt-get install ruby ruby-dev`
2. install chef
  * `sudo apt-get install chef` (or) `sudo gem install --no-ri --no-rdoc chef`
3. install ffi-yajl compatible with ruby1.9.3 (again running into dependency incompatibility with older Ruby versions...)
  * `sudo gem install --no-ri --no-rdoc ffi-yajl -v 2.2.3`
4. install ohai compatible with ruby 1.9...
  * `sudo gem install --no-ri --no-rdoc ohai -v 7.4.1`
5. install knife-solo
  * `sudo gem install --no-ri --no-rdoc knife-solo`
