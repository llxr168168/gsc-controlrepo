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
       fail('NOTICE: You have not set custom_admin_org.Please see http://tswiki.sherwin.com/index.php/Puppet5#facts.d')
}
unless $::custom_admin_org {
       fail('NOTICE: You have not set custom_admin_org. Please see http://tswiki.sherwin.com/index.php/Puppet5#facts.d')
}
if $::custom_admin_org != 'gsc' {
       fail('custom_admin_org is set to something other than gsc but you're using the gsc control repo! Too scary, I quit.')
}

if $::custom_admin_org == 'gsc' {
  unless $::custom_platform {
    fail('NOTICE: You have not set custom_platform, required.Please see http://tswiki.sherwin.com/index.php/Puppet5#facts.d')
  }
  unless $::custom_datacenter {
    fail('NOTICE: You have not set custom_datacenter, required.Please see http://tswiki.sherwin.com/index.php/Puppet5#facts.d')
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

