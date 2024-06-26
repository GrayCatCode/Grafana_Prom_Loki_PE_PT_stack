#!/bin/bash

set -euo pipefail

#sudo "/Applications/lghub.app/Contents/Frameworks/lghub_updater.app/Contents/MacOS/lghub_updater" --uninstall
sudo rm -rf "/Applications/lghub.app"
sudo rm -rf "/Users/$(whoami)/Library/Application Support/lghub"
sudo rm -rf "/Users/Shared/LGHUB/"
sudo rm -rf "/Users/Shared/.logishrd"
