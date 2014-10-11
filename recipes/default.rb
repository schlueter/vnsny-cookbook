node['project_data']['packages'].each do |pckg|
  package pckg
end

node['project_data']['gems'].each do |pckg|
  gem_package pckg
end

include_recipe 'vnsny::vagrant_user'
include_recipe 'vnsny::mysql_setup'
include_recipe 'vnsny::apache_setup'
include_recipe 'vnsny::drupal_install'
include_recipe 'vnsny::site_setup'
