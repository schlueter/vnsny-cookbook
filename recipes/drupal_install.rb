app_name = node['project_data']['name']
deploy_dir = "#{node['project_data']['workspace_dir']}/web"
db_host = 'localhost'
db_pass = node['project_data']['name']
db_user = node['project_data']['name']
db_name = node['project_data']['name']
profile_name = node['project_data']['profile_name']

template "#{deploy_dir}/sites/default/settings.php" do
  source "settings.php.erb"
  owner "www-data"
  group "www-data"
  mode 0777
  variables({
    base_url: node['project_data']['base_url'],
    db_host: db_host,
    db_name: db_name,
    db_pass: db_pass,
    db_user: db_user,
    drupal_table_prefix: node['project_data']['drupal_table_prefix'],
    profile_name: node['project_data']['profile_name']
  })
end

# make sure sites/default/files is world readable and apache writeable
directory "#{deploy_dir}/sites/default/files" do
  owner 'vagrant'
  group 'www-data'
  mode 0755
end

# make sure drupal's scratch space (tmp://) is writeable
directory '/tmp/php' do
  mode 0777
end

# unfortunately, composer installs drush in /root; hack: make that executable for everyone
directory '/root' do
  mode 0701
end

execute 'site-install' do
  command <<-COMMAND
  /usr/bin/drush site-install #{profile_name}
   --db-url=mysql://#{db_user}:#{db_pass}@#{db_host}/#{db_name}
   --site-name=#{app_name}
   --account-name=admin --account-pass=elephant -y
   && /usr/bin/drush user-add-role "administrator" admin
  COMMAND
  cwd deploy_dir
end
