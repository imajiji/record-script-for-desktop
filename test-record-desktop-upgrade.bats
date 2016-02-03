#!/usr/bin/env bats

@test "When no argument provided, it should fail with exit code 1 and print error message" {
  run ./record-desktop-upgrade.sh
  [ "$status" -eq 1 ]
#  [ "${lines[0]}" = "You should specify a file name to check as an argument." ]
}
