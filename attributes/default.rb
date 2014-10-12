default['project_data']['name'] = 'stampede'
default['project_data']['profile_name'] = 'standard'
default['project_data']['hostname'] = "#{node['project_data']['name']}.local.elephantventures.com"
default['project_data']['base_url'] = "http://#{node['project_data']['hostname']}"
default['project_data']['workspace_dir'] = "/home/vagrant/workspace/#{node['project_data']['name']}"
default['project_data']['drupal_table_prefix'] = ""

default['project_data']['database']['skip_tables'] = []

default['project_data']['packages'] = %w{
  php5-curl
  php5-memcache
  php5-mysql
  php5-gd
  php-pear
  ruby1.9.1-dev
}

default['project_data']['gems'] = %w{
  compass
  compass-aurora
}
