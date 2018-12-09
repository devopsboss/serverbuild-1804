## dot files


### Create key

```bash
sudo su devops
cd /home/devops
ssh-keygen -f -t ed25519 -C "gitlab_localdev"
#ssh-keygen -f sshkey_localdev -t ed25519 -C "sshkey_localdev"

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/devops/.ssh/id_ed25519):
Created directory '/home/devops/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/devops/.ssh/id_ed25519.
Your public key has been saved in /home/devops/.ssh/id_ed25519.pub.
```

## Gitlab

### Add key to gitlab

https://gitlab.com/profile/keys > enter public key



### Test & create known_hosts

To test whether your SSH key was added correctly, run the following command

```
sudo su devops
ssh -T git@gitlab.com
```

Enter "yes" if prompted and that would create (or update) `/home/devops/.ssh/known_hosts`


## Github

see https://help.github.com/articles/connecting-to-github-with-ssh/

### Add key to gitlab

https://github.com/settings/keys > click "New SSH Key" > enter public key


### Test & create known_hosts

To test whether your SSH key was added correctly, run the following command

```
sudo su devops
ssh -T git@github.com
```

Enter "yes" if prompted and that would create (or update) `/home/devops/.ssh/known_hosts`

