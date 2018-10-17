node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

filebucket { 'main':
  path   => false
}
File { backup => "main" }

Package {
  allow_virtual => true,
}

virtual::users {'users':}
virtual::groups {'groups':}


### Validate custom_admin_org exists.  Updated to pick_default for puppet device runs.

unless pick_default($::custom_admin_org, hiera('custom_admin_org',undef)){
       fail('
                NOTICE: You have not set custom_admin_org.
                
                The Org should be set in /sw/env/cfg/puppet.d/admin/base_config.yml, key name custom_admin_org.
                NOTE: If this is a new host set environment variable FACTER_custom_admin_org=<value> for the initial 
                run so that this directory path gets created, then set values.

                IF you do not set this value you will be using the global defaults which may not be desired.
                
                Failing Puppet run, set value and try again.
                
                '
       )
}

if $::custom_admin_org == 'gsc' {
  unless $::custom_platform {
    fail('
                  NOTICE: You have not set custom_platform, required.
                  
                  The platform(ie Application) should be set in /sw/env/cfg/puppet.d/admin/base_config.yml, key name custom_platform.
                  NOTE: If this is a new host set environment variable FACTER_custom_platform=<value> for the initial 
                  run.
              '
    )
  }
  unless $::custom_datacenter {
    fail('
                  NOTICE: You have not set custom_datacenter, required.
                  
                  The datacenter(ie Location) should be set in /sw/env/cfg/puppet.d/admin/base_config.yml, key name custom_datacenter.
                  NOTE: If this is a new host set environment variable FACTER_custom_datacenter=<value> for the initial 
                  run.
              '
    )
  }
}
# 
#if $::custom_admin_org == 'gcd' {
#  if $::custom_platform != ''  {
#         fail('
#                  NOTICE: You have set custom_platform you should be using Roles and Profiles.
#              '
#         )
#  }
#  unless $::custom_datacenter {
#         fail('
#                  NOTICE: You have not set custom_datacenter, required.
#
#                  The datacenter(ie Location) should be set in /etc/sysconfig/pe-puppet, key name FACTER_custom_datacenter .
#              '
#         )
#  }
#}

### Allow Hiera to drive class inclusion
hiera_include('classes')

