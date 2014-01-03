def whyrun_supported?
  true
end
use_inline_resources
action :create do
  directory dir do
    owner node['btsync']['setup']['user']
    group node['btsync']['setup']['user']
    mode "0755"
    recursive true
    action :create
  end
  Shared_Folder_Name = new_resource.name
  node.default['btsync']['shared_folders'][Shared_Folder_Name]['dir'] = new_resource.path
  node.default['btsync']['shared_folders'][Shared_Folder_Name]['secret'] = new_resource.secret
  converge_by("update the node data with sync path and secret that was added") do
    node.set['btsync'][Shared_Folder_Name]['dir'] = new_resource.path
    node.set['dbnodes = search(:node, "role:percona")'][Shared_Folder_Name]['secret'] = new_resource.secret
    node.save unless Chef::Config[:solo]
  end
  if new_resource.has_key?('use_relay_server')
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_relay_server'] = new_resource.use_relay_server
  else
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_relay_server'] = node['btsync']['shared_folder_options']['use_relay_server']
  end
  if new_resource.has_key?('use_tracker')
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_tracker'] = new_resource.use_tracker
  else
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_tracker'] = node['btsync']['shared_folder_options']['use_tracker']
  end
  if new_resource.has_key?('use_dht')
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_dht'] = new_resource.use_dht
  else
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_dht'] = node['btsync']['shared_folder_options']['use_dht']
  end
  if new_resource.has_key?('search_lan')
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['search_lan'] = new_resource.search_lan
  else
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['search_lan'] = node['btsync']['shared_folder_options']['search_lan']
  end
  if new_resource.has_key?('use_sync_trash')
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_sync_trash'] = new_resource.use_sync_trash
  else
    node.default['btsync']['shared_folders'][Shared_Folder_Name]['use_sync_trash'] = node['btsync']['shared_folder_options']['use_sync_trash']
  end

  if new_resource.use_search
    if Chef::Config[:solo]
      Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
    else
      KnownHosts = search(:node, "btsync:#{Shared_Folder_Name}")
      SharedHosts = nil

    end
  end
end
