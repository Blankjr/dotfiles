#!/bin/sh
cat codium_installed_extensions.txt | xargs -L 1 codium --install-extension
