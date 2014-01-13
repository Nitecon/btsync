def whyrun_supported?
  true
end
use_inline_resources
action :create do
  directory new_resource.path do
    owner node['btsync']['setup']['user']
    group node['btsync']['setup']['user']
    mode "0755"
    recursive true
    action :create
  end
  converge_by("Verifying and updating shared folder for #{new_resource.name}\n") do
    node.override['btsync']['shared_folders'][new_resource.name]['dir'] = new_resource.path
    node.override['btsync']['shared_folders'][new_resource.name]['secret'] = new_resource.secret
    node.override['btsync']['shared_folders'][new_resource.name]['use_relay_server'] = new_resource.use_relay_server
    node.override['btsync']['shared_folders'][new_resource.name]['use_tracker'] = new_resource.use_tracker
    node.override['btsync']['shared_folders'][new_resource.name]['use_dht'] = new_resource.use_dht
    node.override['btsync']['shared_folders'][new_resource.name]['search_lan'] = new_resource.search_lan
    node.override['btsync']['shared_folders'][new_resource.name]['use_sync_trash'] = new_resource.use_sync_trash
    #node.save unless Chef::Config[:solo]
  end

end
