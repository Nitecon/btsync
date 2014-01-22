btsync Cookbook
===============
Fast, unlimited &amp secure file-syncing.  Free from the cloud. Sync never stores your files on servers, so they stay safe from data breaches and prying eyes.
A more detailed and in depth FAQ and documentation about bittorrent sync can be found on: http://www.bittorrent.com/sync

The btsync cookbook installs bittorrent sync and provides a simple LWRP for adding shared folders that are to be synced between multiple servers.
When using a hosted chef install you will be able to use the search feature to automatically find and add additional nodes to bittorrent sync without making any modifications.

Requirements
------------
Please note btsync on linux requires glibc 2.3 or greater.

Attributes
----------
TODO: Full attributes will be completed soon.

#### btsync::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['btsync']['setup']['user']</tt></td>
    <td>String</td>
    <td>The user that the btsync daemon will run as</td>
    <td><tt>webserv</tt></td>
  </tr>
  <tr>
    <td><tt>['btsync']['setup']['bin_dir']</tt></td>
    <td>String</td>
    <td>Where the binary will be installed to (should be in your path)</td>
    <td><tt>/usr/local/bin/</tt></td>
  </tr>
</table>


Usage
-----
#### btsync::default
Just include `btsync` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[btsync::default]"
  ]
}
```

Then add a path and options to your server role like so:

```json
{
    "name": "examplerole",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Example Role for BTSYNC",
    "override_attributes": {
        "btsync":{
            "setup":{
                "user": "httpd",
                "group": "httpd"
            },
            "main_options":{
                "storage_path": "/data/btsync",
                "webui":{
                    "password": "SomeCoolPasswordForTheUI"
                }
            },
            "shared_folders":{
                "DescriptiveNameForPathToSearchON":{
                    "dir":"/path/to/some/directory/",
                    "secret":"S0M3L0NGB7SYNCG3N3R4T3DS3CR37",
                    "SyncIgnore":[".DS_Store",".DS_Store?","._*",".Spotlight-V100",".Trashes","Icon?","ehthumbs.db","desktop.ini","Thumbs.db","somefile.log","logs/*"]
                 },
                "AnotherDirectoryToSync":{
                  "dir":"/path/to/some/other/directory/",
                  "secret":"S0M3L0NGB7SYNCG3N3R4T3DS3CR372",
                  "SyncIgnore":[".DS_Store",".DS_Store?","._*",".Spotlight-V100",".Trashes","Icon?","ehthumbs.db","desktop.ini","Thumbs.db","somefile.log"]
                }
               }
            }
        }
    },
    "run_list": [
        "recipe[btsync::default]"
    ]
}

```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Will Hattingh &amp; contributors https://github.com/Nitecon/btsync/graphs/contributors
