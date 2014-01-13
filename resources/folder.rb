actions :create

default_action :create

#required stuff
attribute :name,              	:kind_of => String, :name_attribute => true
attribute :path,            	:kind_of => String, :required => true
attribute :secret,            	:kind_of => String, :required => true
attribute :use_relay_server,   	:kind_of => [TrueClass, FalseClass], :required => false, :default => node['btsync']['shared_folder_options']['use_relay_server'] != nil ? node['btsync']['shared_folder_options']['use_relay_server'] : false
attribute :use_tracker,  		:kind_of => [TrueClass, FalseClass], :required => false, :default => node['btsync']['shared_folder_options']['use_tracker'] != nil ? node['btsync']['shared_folder_options']['use_tracker'] : false
attribute :use_dht,           	:kind_of => [TrueClass, FalseClass], :required => false, :default => node['btsync']['shared_folder_options']['use_dht'] != nil ? node['btsync']['shared_folder_options']['use_dht'] : false
attribute :search_lan,  		:kind_of => [TrueClass, FalseClass], :required => false, :default => node['btsync']['shared_folder_options']['search_lan'] != nil ? node['btsync']['shared_folder_options']['search_lan'] : false
attribute :use_sync_trash,  	:kind_of => [TrueClass, FalseClass], :required => false, :default => node['btsync']['shared_folder_options']['use_sync_trash'] != nil ? node['btsync']['shared_folder_options']['use_sync_trash'] : false
attribute :default_hosts,  		:kind_of => Array, :required => false, :default => nil
attribute :use_search,  		:kind_of => [TrueClass, FalseClass], :required => false, :default => false
