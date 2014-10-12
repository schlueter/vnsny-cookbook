directory '/home/vagrant/.ssh' do
  mode 0700
end

cookbook_file '/home/vagrant/.ssh/id_rsa' do
  mode 0600
  owner 'vagrant'
  group 'vagrant'
end
