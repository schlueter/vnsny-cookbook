web_app node['project_data']['name'] do
  server_name node['project_data']['hostname']
  server_aliases [node['project_data']['hostname']]
  docroot "#{node.project_data.workspace_dir}/web"
  allow_override "All"
end

### a kludge since the name of the default site seems to have changed from 2.2 to 2.4?
apache_site 'default' do
  enable false
end
apache_site '000-default.conf' do
  enable false
end
