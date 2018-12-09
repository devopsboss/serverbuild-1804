## Setting up github credentials


Create key, add to authorized_keys, set permissions, and compress 
```bash
# create key
ssh-keygen -t rsa
cat id_rsa.pub >> authorized_keys

# ssh permissions
cd /home/ubuntu/
sudo chmod 700 .ssh
sudo chmod 600 .ssh/*
sudo chown -R ubuntu:ubuntu .ssh

# compress .ssh folder
cd /home/ubuntu
tar jcvf github-ssh.tar.bz2 .ssh 
```

Then upload the file to S3 `%server-build-assets%` bucket and ensure `id_rsa.pub` output has been added to github account


### Testing

```bash
ssh -T git@github.com
```
