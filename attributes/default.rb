# Values for platform can be "pi", "pi2" (works for pi3), "bbb", "test"
default['dht']['platform'] = "pi2"
# Values for sensor can be "11", "22", "2302"
default['picubator']['sensor']['type'] = 2302
# Pick a GPIO port number for reading, can be any valid gpio pin number
default['picubator']['sensor']['pin_num'] = 4
# Pick a pin number for the heater power control pin
default['picubator']['heat']['power_control_pin_num'] = 23

# Attributes for Adafruit IO dashboard functionality
default['picubator']['adafruitio']['key'] = nil
default['picubator']['adafruitio']['temperature_feed_name'] = 'picubator-temperature'
default['picubator']['adafruitio']['humidity_feed_name'] = 'picubator-humidity'
default['picubator']['adafruitio']['temperature_threshold_feed_name'] = 'picubator-threshold'
default['picubator']['adafruitio']['main_toggle_feed_name'] = 'picubator-toggle'

# Installation Attributes
default['picubator']['app_root'] = '/opt/'
default['picubator']['config_dir'] = '/etc/picubator/'
