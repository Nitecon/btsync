#
# Cookbook Name:: btsync
# Recipe:: default
#
# Copyright 2014, Web Services
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
directory node['btsync']['main_options']['storage_path'] do
  owner node['btsync']['setup']['user']
  group node['btsync']['setup']['group']
  mode "0775"
  action :create
  recursive true
end
directory node['btsync']['main_options']['pid_dir'] do
  owner node['btsync']['setup']['user']
  group node['btsync']['setup']['group']
  mode "0775"
  recursive true
  action :create
end
directory node['btsync']['main_options']['settings_file_dir'] do
  owner node['btsync']['setup']['user']
  group node['btsync']['setup']['group']
  mode "0755"
  action :create
end
node.set['btsync']['enabled'] = true
optionsFile = node['btsync']['main_options']['settings_file_dir'] + "/" + node['btsync']['main_options']['settings_file_name']
sharedFolders = node['btsync']['shared_folders']
if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
	KnownHosts = search(:node, "btsync:* NOT name:#{node.name}")
  	sharedFolders.each do |name,sf|
  		searched_sync_servers = Array.new
    	KnownHosts.each do |servernode|
    		
    		btsync = servernode['btsync']
	      	if !btsync.is_a?(String) && btsync.has_key?("shared_folders") && btsync['shared_folders'].has_key?(name) && btsync['enabled']
	      		puts YAML::dump(servernode['btsync']['shared_folders'][name]['secret'])
	      		puts YAML::dump(sf)
	      		if servernode['btsync']['shared_folders'][name]['secret'] == sf['secret']
	        		searched_sync_servers << servernode['ipaddress']
	        	end
	      	end
    	end
    	node.set['btsync']['shared_folders'][name]['sync_servers'] = searched_sync_servers
  end
end

template optionsFile do
  source "btsync-options.json.erb"
  owner node['btsync']['setup']['user']
  group node['btsync']['setup']['group']
  mode "0644"
  notifies :restart, "service[btsync]"
  variables(
    {
      :use_relay_server => node['btsync']['shared_folder_options']['use_relay_server'],
      :use_tracker => node['btsync']['shared_folder_options']['use_tracker'],
      :use_dht => node['btsync']['shared_folder_options']['use_dht'],
      :search_lan => node['btsync']['shared_folder_options']['search_lan'],
      :use_sync_trash => node['btsync']['shared_folder_options']['use_sync_trash'],
      :sharedFolders => sharedFolders
    }
  )
end
# Create service
#
template "/etc/init.d/btsync" do
  source "init-script.sh.erb"
  owner node['btsync']['setup']['user']
  group node['btsync']['setup']['group']
  mode "0755"
  variables(
    {
      :btsync_user => node['btsync']['setup']['user'],
      :options_file => optionsFile,
      :pid_file => node['btsync']['main_options']['pid_dir'] + "/" + node['btsync']['main_options']['pid_file'],
      :executable => node['btsync']['setup']['bin_dir']+"/btsync"
    }
  )
end
download_url = ""
case node["languages"]["ruby"]["host_cpu"]
when "x86_64"
  download_url << "http://btsync.s3-website-us-east-1.amazonaws.com/btsync_x64.tar.gz"
when "i686"
  download_url << "http://btsync.s3-website-us-east-1.amazonaws.com/btsync_i386.tar.gz"
end

remote_file "Download BTSYNC Binary" do
  path "/tmp/btsync.tar.gz"
  source download_url
  backup false
  notifies :run, "execute[Unpack BTSYNC Tarball]", :immediately
  not_if "test -f #{node['btsync']['setup']['bin_dir']}/btsync"
end

execute "Unpack BTSYNC Tarball" do
  cwd "/tmp"
  command "tar -xvzf /tmp/btsync.tar.gz; mv btsync #{node['btsync']['setup']['bin_dir']}/ && chmod +x #{node['btsync']['setup']['bin_dir']}/btsync"
  creates node['btsync']['setup']['bin_dir']+"/btsync"
  action :nothing
  notifies :restart, "service[btsync]", :immediately
end


service 'btsync' do
  case node['platform_family']
  when 'rhel', 'fedora', 'suse','centos'
    service_name 'btsync'
    restart_command '/sbin/service btsync restart && sleep 1'
    reload_command '/sbin/service btsync reload && sleep 1'
  when 'debian'
    service_name 'btsync'
    restart_command '/usr/sbin/invoke-rc.d btsync restart && sleep 1'
    reload_command '/usr/sbin/invoke-rc.d btsync reload && sleep 1'
  when 'arch'
    service_name 'btsync'
  when 'freebsd'
    service_name 'btsync'
  end
  supports [:restart, :reload, :status]
  action :enable
end
