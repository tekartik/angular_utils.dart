#!/bin/bash

# Fast fail the script on failures.
set -xe

dartanalyzer --fatal-warnings lib test

pub run test -p vm,firefox,chrome