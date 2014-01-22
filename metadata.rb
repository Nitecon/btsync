name             'btsync'
maintainer       'Will Hattingh'
maintainer_email 'w.hattingh@nitecon.com'
license          'Apache 2.0'
description      'Installs/Configures btsync'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.27'
recipe            'btsync', 'Main Btsync configuration'
depends 'partial_search'

supports 'amazon'
supports 'arch'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'freebsd'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'


attribute 'btsync',
          :display_name => 'Btsync Hash',
          :description  => 'Hash of btsync attributes',
          :type         => 'hash'