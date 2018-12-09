#!/usr/bin/env bash

# These should be set to 027
grep umask /etc/init/ssh.conf
grep umask /etc/init.d/ssh
grep umask /etc/init.d/umountfs
grep umask /etc/init.d/sysstat
grep umask /etc/init.d/rc
grep umask /etc/profile
