#!/usr/bin/env bash

# adds an advisor-role and appropriate permissions

## check for and create the role if it does not exist
drush -r /var/www/drupal/ role-list | grep -o 'advisor-role' && echo "advisor-role exists" || drush -r /var/www/drupal/ role-create 'advisor-role'

## add advisor-role permissions
declare -a ADVISOR_PERMS=(
	"view fedora repository objects"
	"search islandora solr"
	"ingest fedora objects"
	"add fedora datastreams" #islandora
	"view old datastream versions"
	"use islandora_bookmark"
	"share islandora bookmarks"
	"export islandora bookmarks"
	"can embargo owned objects"
	"bypass inactive object state"
)

## iterate over the list of permissions and verify that they're added
drush_advisor_role_perm_check() {
	echo "Verifying advisor-role permissions..."
	for i in "${ADVISOR_PERMS[@]}"
	do
		drush -r /var/www/drupal/ role-add-perm 'advisor-role' "$i"
	done
}

# execute!
drush_advisor_role_perm_check

## we aren't automatically assigning this role to a given user right now
