#!/bin/sh

# USAGE:
# sudo /srv/serverbuild-1804/www/scripts/composer_install.sh
# sudo /vagrant/www/scripts/composer_install.sh


# SOURCE: https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
# ref: https://getcomposer.org/download/

EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet --filename=composer
RESULT=$?
rm composer-setup.php
exit ${RESULT}
