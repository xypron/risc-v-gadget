#!/bin/sh

FK_FORCE=yes flash-kernel $(find /boot -name 'vmlinuz-*' | sed -e 's|^[^-]*-||')
