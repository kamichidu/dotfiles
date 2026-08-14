#!/bin/bash

set -e -u

cd "$(dirname "${0}")/configurator/"

# unable to avoid tty problem on installing homebrew in ansible.
# so install before running ansible.
if [[ ! -x '/opt/homebrew/bin/brew' ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! /usr/bin/python3 -m ansible playbook --version; then
    /usr/bin/pip3 install ansible
fi

/usr/bin/python3 -m ansible playbook \
    --become-user "$(whoami)" \
    -i hosts \
    -vvv \
    osx.yml
