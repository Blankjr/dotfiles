#!/bin/sh
cat codium_installed_extensions.txt | xargs -L 1 code --install-extension
