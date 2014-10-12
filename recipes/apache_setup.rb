web_app node['project_data']['name'] do
  server_name node['project_data']['hostname']
  server_aliases [node['project_data']['hostname']]
  docroot "#{node['project_data']['workspace_dir']}/web"
  allow_override "All"
  cookbook 'vnsny'
end

# Copied from the apache2::default recipe in order to override the file
template 'apache2.conf' do
  case node['platform_family']
  when 'rhel', 'fedora', 'arch'
    path "#{node['apache']['dir']}/conf/httpd.conf"
  when 'debian'
    path "#{node['apache']['dir']}/apache2.conf"
  when 'freebsd'
    path "#{node['apache']['dir']}/httpd.conf"
  end
  source   'apache2.conf.erb'
  owner    'root'
  group    node['apache']['root_group']
  mode     '0644'
  notifies :reload, 'service[apache2]'
end

### a kludge since the name of the default site seems to have changed from 2.2 to 2.4?
apache_site 'default' do
  enable false
end

apache_site '000-default.conf' do
  enable false
end
