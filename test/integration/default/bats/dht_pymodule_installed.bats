#!/usr/bin/env bats

@test "Adafruit_DHT python module can be imported" {
  run python -c "import Adafruit_DHT"
  [ "$status" -eq 0 ]
}
