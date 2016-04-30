# http://qiita.com/kenji0x02/items/8b01d65608aa4ac30e09

package 'git' do
  action :install
end

git '/nvm' do
  repository 'git://github.com/creationix/nvm.git'
  reference 'master'
  action :sync
end

template '/etc/profile.d/nvm.sh' do
  source 'nvm.sh.erb'
  mode 00644
end

directory '/nvm/alias' do
  action :create
end

target = '/nvm/versions/node'

bash 'install nodejs' do
  code <<-EOC
    source /nvm/nvm.sh
    nvm install #{node['nodejs']['version']}
  EOC
  not_if {File.exists?("#{target}/v#{node['nodejs']['version']}")}
end

link '/usr/local/bin/node' do
  to "#{target}/#{node['nodejs']['version']}/bin/node"
end

link '/usr/local/bin/npm' do
  to "#{target}/#{node['nodejs']['version']}/bin/npm"
end

bash 'npm install npm' do
  code "npm install -g npm@#{node[:nodejs][:npm][:version]}"
end
