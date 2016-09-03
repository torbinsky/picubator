# Values for platform can be "pi", "pi2" (works for pi3), "bbb", "test"
default['dht']['platform'] = "pi2"
# Values for sensor can be "11", "22", "2302"
default['picubator']['sensor']['type'] = 2302
# Pick a GPIO port number for reading, can be any valid gpio pin number
default['picubator']['sensor']['gpio'] = 4
# Pick a pin number for the heater power control pin
default['picubator']['heat']['powerControlPinNum'] = 23
