#!/bin/bash

# Fast fail the script on failures.
set -e

dartanalyzer --fatal-warnings lib test

pub run test -p vm,firefox,chrome