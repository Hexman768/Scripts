#!/usr/bin/env bash
set -euo pipefail

echo "Current ssh-agent identities:"
if ! ssh-add -l; then
  true
fi

if ssh-add -l 2>/dev/null | grep -q "The agent has no identities"; then
  echo "Loading YubiKey PKCS#11 key into ssh-agent..."
  ssh-add -s /usr/local/lib/opensc-pkcs11-hack.so
else
  echo "ssh-agent already has identities loaded."
fi

echo "Updated ssh-agent identities:"
ssh-add -l
