#!/bin/bash

# Fast fail the script on failures.
set -e

dartanalyzer --fatal-warnings \
  lib/component/side_bar_layout/side_bar_layout.dart \

pub run test -p vm,firefox,chrome