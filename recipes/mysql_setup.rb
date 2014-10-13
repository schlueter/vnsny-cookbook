# Creates the project mysql database
mysql_database node['project_data']['name'] do
  connection(
    host: 'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  )
  action :create
end

# Creates the project mysql user and grants access
mysql_database_user node['project_data']['name'] do
  connection (
    host: 'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  )
  password node['project_data']['name']
  database_name node['project_data']['name']
  host 'localhost'
  privileges [:all]
  action :create
  action :grant
end
