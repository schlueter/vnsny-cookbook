data_bag_item = Chef::EncryptedDataBagItem.load 'secrets', 'id_rsa'

directory '/home/vagrant/.ssh' do
  mode 0700
end

file '/home/vagrant/.ssh/id_rsa' do
  content data_bag_item['private_key']
  mode 0600
  owner 'vagrant'
  group 'vagrant'
end
