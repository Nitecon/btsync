actions :create

default_action :create

#required stuff
attribute :name,              	:kind_of => String, :name_attribute => true
attribute :path,            	:kind_of => String, :required => true
attribute :secret,            	:kind_of => String, :required => true
attribute :use_relay_server,   	:kind_of => [TrueClass, FalseClass], :required => false
attribute :use_tracker,  		:kind_of => [TrueClass, FalseClass], :required => false
attribute :use_dht,           	:kind_of => [TrueClass, FalseClass], :required => false
attribute :search_lan,  		:kind_of => [TrueClass, FalseClass], :required => false
attribute :use_sync_trash,  	:kind_of => [TrueClass, FalseClass], :required => false
attribute :default_hosts,  		:kind_of => Array, :required => false
attribute :use_search,  		:kind_of => [TrueClass, FalseClass], :required => false