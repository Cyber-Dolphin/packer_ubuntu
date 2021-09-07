#!/bin/bash -eux

# Install dependencies.

apt -y update && apt-get -y upgrade

apt -y install python-pip python-dev apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    fail2ban \
    ufw

# Add SSH key for auto

mkdir /home/sadmin/.ssh

chown sadmin:sadmin /home/sadmin/.ssh

chmod 700 /home/sadmin/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAihszCDwPZ51513OgSpPzAAL/Cw2XrH2Kmto0eNQ7kItMozBRtL5Nv2BEsE+kycgoQZzoi4hdIc1p8CZp4tRoniVt5Mmah6xamDPNvHvVGKutWCE53IqhfdWH8zQPq+Xsleczc2ae3bhg3ZzPQ52e7hK4oXgSTlGKw8ryjS+zkKOUhKkktfR+3L/v/0cOQQYhP4FNr3Y2zFQU3anfXU2dxkafWAr6Q1KTaJDnm1dGdnvGxx0xqoLT2IVBnqTjzJ+I4PJENYZQzR/QTvm9Lz73MHG96hWo848T+IpjLe3K49toqauLdXbSXGtwr3TXRUHCjYhlxauV6MwHoBH44LJxTQ== sadmin" | tee /home/sadmin/.ssh/authorized_keys

chown sadmin:sadmin /home/sadmin/.ssh/authorized_keys

chmod 600 /home/sadmin/.ssh/authorized_keys

# Add SSH key for ME

useradd -m cyberdolphin

mkdir /home/cyberdolphin/.ssh

chown cyberdolphin:cyberdolphin /home/cyberdolphin/.ssh

chmod 700 /home/cyberdolphin/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAjzQ6BUXaNZ2XqxDvorqdajh1zMySizYzmXzpFsqbKTEsHANMTB9WLkpMBq2/bC7z3C/pJ4S+mT6ErAYGvrTWaiToQWzeguuoac9trwXsYj4RTp9eaBTJ5SAfjqyv/tGaMF9rlIzJmquD/J0nDJVUqNDnOzeu37rSmuK2XFSzwUZrvOLz+WSbwIL/Srhc/7UrxAjKwRPbgULwwcuVAu0D2YnOWerUfeiJ192CPq0v9kmLeLZL4WVT0vA2vyw6FqF21c/VKAzHtrBdx01u+X17spEVUeZPgv3A6yPcRJLNmua67M4MUe/AseNbXgBmiNZqA1iSY8Vvkd9Vwi1M1Bbjgw== cyberdolphin" | tee /home/cyberdolphin/.ssh/authorized_keys

chown cyberdolphin:cyberdolphin /home/cyberdolphin/.ssh/authorized_keys

chmod 600 /home/cyberdolphin/.ssh/authorized_keys

usermod -aG sudo cyberdolphin

# Add admin no passwd SUDO

echo "sadmin ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

echo "cyberdolphin ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Settings SSH

echo "PasswordAuthentication no" | tee -a /etc/ssh/sshd_config

service ssh restart

service sshd restart

# Setings FW

ufw allow OpenSSH

echo "y" | ufw enable

# Change password for sadmin

printf 'sadmin:$6$c0qOW7LuxaJr8qsB$kXYJybBY91J6T0y19.FUs6erAFxbNtW4cLN.amS9ZLf8LSG1wicC5N5SOdjlsWmw3mdQyZA6beSLiF2cDHEeb1' | chpasswd --encrypted

