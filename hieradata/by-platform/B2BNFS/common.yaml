classes:
   - sw_util::hiera_wrapper
   
avamar::client::version: "7.3.101-125"

sw_util::wrapper::hiera_package::params:
   - rpcbind: {}
   - nfs-utils: {}
   - nfs-utils-lib: {}
   - AvamarClient: {ensure: "%{hiera('avamar::client::version')}"}
