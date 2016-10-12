#!/usr/bin/env bash

echo "drush enable theme"
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/themes
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/themes
cd "$DRUPAL_HOME"/sites/all/themes || exit
git clone https://github.com/utkdigitalinitiatives/UTKdrupal
sudo chown -hR vagrant:www-data UTKdrupal
drush -y -u 1 en pm-enable UTKdrupal
drush -y -u 1 en vset theme_default UTKdrupal
#uncomment below to set as default
drush eval "variable_set('theme_default', 'UTKdrupal')"
