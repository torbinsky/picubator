# picubator

This is a Chef cookbook for deploying the `picubator-app` project to a Raspberry Pi. So far I have tested this on Raspbian Jessie and it works well. It also works on debian-8 via Vagrant, but you can't actually run the application as the Python libraries used by the app have ARM binaries and Vagrant is not able to simulate ARM.

## What this cookbook does:
- Configures picubator-app
  - Which sensor pins are used for sensor,camera
  - adafruit.io (IoT dashboard) settings
- Installs picubator-app
  - Upstart/systemd daemon ensuring picubator-app is always running
  - Application config file
  - Install Python packages used by picubator-app
  - Install DHT22 sensor driver
  - Download picubator-app from Github
