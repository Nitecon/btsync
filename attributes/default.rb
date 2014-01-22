default['btsync']['setup']['user'] = "root"
default['btsync']['setup']['group'] = "root"
default['btsync']['setup']['bin_dir'] = "/usr/local/bin"
default['btsync']['main_options']['device_name'] = Chef::Config[:node_name]
default['btsync']['main_options']['listening_port'] = '44444'
default['btsync']['main_options']['storage_path'] = '/data/btsync'
default['btsync']['main_options']['pid_dir'] = '/var/run/btsync'
default['btsync']['main_options']['pid_file'] = 'btsync.pid'
default['btsync']['main_options']['settings_file_dir'] = '/etc/btsync'
default['btsync']['main_options']['settings_file_name'] = 'btsync.conf'
default['btsync']['main_options']['check_for_updates'] = 'true'
default['btsync']['main_options']['use_upnp'] = 'false'
default['btsync']['main_options']['download_limit'] = '0'
default['btsync']['main_options']['upload_limit'] = '0'
default['btsync']['main_options']['webui']['listen'] = '0.0.0.0:8888'
default['btsync']['main_options']['webui']['login'] = 'admin'
default['btsync']['main_options']['webui']['password'] = 'password'
default['btsync']['main_options']['disk_low_priority'] = 'false'
default['btsync']['main_options']['folder_rescan_interval'] = '600'
default['btsync']['main_options']['lan_encrypt_data'] = 'true'
default['btsync']['main_options']['lan_use_tcp'] = 'true'
default['btsync']['main_options']['rate_limit_local_peers'] = 'false'
default['btsync']['main_options']['sync_max_time_diff'] = '300'
default['btsync']['main_options']['sync_trash_ttl'] = '30'
default['btsync']['known_hosts'] = %w[127.0.0.1 10.91.34.191]

# These are default values for all of your shared folders that are added through LWRP
# You may still specify these manually through the LWRP but in general I have found
# that once the options are decided on it makes more sense to keep everything consistent
# and override only where it's absolutely necessary to overcome network issues.

default['btsync']['shared_folder_options']['use_relay_server'] = 'false'
default['btsync']['shared_folder_options']['use_tracker'] = 'false'
default['btsync']['shared_folder_options']['use_dht'] = 'false'
default['btsync']['shared_folder_options']['search_lan'] = 'true'
default['btsync']['shared_folder_options']['use_sync_trash'] = 'false'
default['btsync']['shared_folder_options']['SyncIgnore'] = %W[.DS_Store .DS_Store? ._* .Spotlight-V100 .Trashes ehthumbs.db desktop.ini]
#default['btsync']['shared_folders'] = %w[]
# The list of *default* shared folders are listed below
# If you decide to use the shared folders then the WebUI will be disabled and no longer usable
# Enabling the shared folders with use_search will enable automatic finding and adding of host

# Adding folders without using an LWRP can be done by adding the following as your own attributes
# A generic name must be specified for the top level key Ex: FooBarFolder
# Required Value to specify the directory to be synced ##
#default['btsync']['shared_folders']['FooBarFolder']C = "/path/to/some/directory"
# Required Value to specify the shared secret to be used during sync ##
#default['btsync']['shared_folders']['FooBarFolder']['secret'] = "AVERYLONGKEYTOBEUSEDASSECRET" 
# Optional (It will use the shared_folder_options value if not specified) ##
#default['btsync']['shared_folders']['FooBarFolder']['use_relay_server'] = 'false'
# Optional (It will use the shared_folder_options value if not specified) ##
#default['btsync']['shared_folders']['FooBarFolder']['use_tracker'] = 'false'
# Optional (It will use the shared_folder_options value if not specified) ##
#default['btsync']['shared_folders']['FooBarFolder']['use_dht'] = 'false'
# Optional (It will use the shared_folder_options value if not specified) ##
#default['btsync']['shared_folders']['FooBarFolder']['search_lan'] = 'true'
# Optional (It will use the shared_folder_options value if not specified) ##
#default['btsync']['shared_folders']['FooBarFolder']['use_sync_trash'] = 'false'


#default['btsync']['shared_folder_options']['excludes'] = %w[.DS_Store .DS_Store? ._* .Spotlight-V100 .Trashes ehthumbs.db desktop.ini]
