## Security report scripts

- see C:\Projects\serverbuild-1804\server\www\puppet\modules\security\manifests\params.pp


- Nightly security report than writes to `/var/log/security.log`
- cron.d example: `11 0 * * * root (echo "`date` - security: " && /var/serverbuild-1804/projects/serverbuild-1604/www/scripts/security/run_all_for_prod.sh) >> /var/log/cron.d.log 2>&1`

| Script                        | Description   |
| ----------------------------- | ------------- |
| aide_check.sh                 | List of changed files |
| audit_report.sh               | Summary reports of the audit system logs |
| clamscan_antivirus.sh         | Virus scan of all files |
| composer_checker.sh           | Checks composer for known security vulnerabilities |
| fail2ban_status.sh            | Jail status for `sshd` and `modsec-bad_user_agent` |
| find_777_files_and_folders.sh | List of files & folders with 777 permissions |
| lynis_audit_system.sh         | Logs any warnings from lynis audit report |
| rkhunter.sh                   | Scans for rootkits, backdoors and possible local exploits |



## Packages & Config


### Anti-virus / malware / rootkit

- clamav - Anti-virus scanner
- freshclam - keeps clamav database up-to-date
- chkrootkit - Linux rootkit scanner (http://www.chkrootkit.org/)
- rkhunter - Scans for rootkits, backdoors and possible local exploits


### Audit

- auditd - Writes audit records to the disk
- chrony - implementation of the Network Time Protocol (NTP). It can synchronise the system clock with NTP servers
- lynis - Audits system and provides guidance for system hardening and compliance testing

Auditd config:
- Set max_log_file_action to "keep_logs".
- Ensure that auditing will occur during boot before auditd is started by adding `GRUB_CMDLINE_LINUX="audit=1"` in `/etc/default/grub`

Chrony config:
- Installed "chrony" package and updated config to use "Amazon Time Sync Service IP address"


### Firewall

- Apache mod security
- fail2ban - scans log files (e.g. /var/log/apache/error_log) and bans IPs that show the malicious sign

Apache mod security config:
- custom rule for bad user agents `files/modsecurity-custom/bad_user_agents.data`

iptables config:
- Default policy for "forward" to drop
- Allowed ip4 ports 80, 443, 22, 53, 3306, 4444, everything else DENY
- Allowed ip6 ports 80, 443, 53, everything else DENY
- Installed iptables-persistent to ensure firewall config is correct on reboot


### Intrusion detection

- AIDE (Advanced Intrusion Detection Environment) host based file and directory integrity checker


### Network Configuration

/etc/sysctl.conf for *_redirects:
- net.ipv6.conf.all.accept_redirects = 0
- net.ipv4.conf.all.accept_redirects = 0
- net.ipv4.conf.all.secure_redirects = 0
- net.ipv4.conf.default.accept_redirects = 0
- net.ipv4.conf.default.secure_redirects = 0
- net.ipv4.conf.all.send_redirects = 0
- net.ipv4.conf.default.send_redirects = 0

/etc/sysctl.conf for log_martians:
- net.ipv4.conf.all.log_martians = 1
- net.ipv4.conf.default.log_martians = 1


### Passwords & Permissions

login.defs config:
- Set PASS_MIN_DAYS to 7 in /etc/login.defs

pam.d config:
- Configured "remember=24" parameter in /etc/pam.d/common-password
- Updated "/etc/pam.d/su" to restrict the use of su to users in the wheel group (only root group can su)
- Set umask to 027 in:
    - grep umask /etc/init/ssh.conf
    - grep umask /etc/init.d/ssh
    - grep umask /etc/init.d/umountfs
    - grep umask /etc/init.d/sysstat
    - grep umask /etc/init.d/rc
    - grep umask /etc/profile


### SSH

Packages
- openssh-server

openssh-server config
- ClientAliveInterval = "300"
- ClientAliveCountMax = "0"
- AllowUsers = "AllowUsers ubuntu"
- X11Fowarding = "no"
- PermitRootLogin = "no"
- KexAlgorithms, Ciphers, MACs, as per guidelines from: https://wiki.mozilla.org/Security/Guidelines/OpenSSH

