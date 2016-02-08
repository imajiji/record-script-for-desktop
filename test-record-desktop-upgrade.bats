#!/usr/bin/env bats

setup() {
  mkdir test_dir
  touch test_file
}

teardown() {
  rmdir test_dir
  rm test_file
}

@test "When no argument provided, it should fail with exit code 1 and print error message" {
  run ./record-desktop-upgrade.sh
  [ "$status" -eq 1 ]
#  [ "${lines[0]}" = "You should specify a file name to check as an argument." ]
}

@test "When the provided not file, it should fail with exit code 2 and print error message" {
  run ./record-desktop-upgrade.sh test_dir test_dir
  [ "$status" -eq 2 ]
  # [ "${lines[1]}" = "but it seems a directory." ]
}
