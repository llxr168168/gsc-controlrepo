access_conf::access:
  - '+:root:LOCAL'
  - "+:%{hiera('sw_puppet_ansible:ansible_user')}:%{hiera('access_conf::ansible_ips')}"
  - '+:oracle:LOCAL %{::fqdn}  10.140.32.22 10.148.5.81 10.140.32.21 10.148.5.80' 
  - "+:oinstall:LOCAL"
  - '+:(sa-local):LOCAL'
  - '+:(sa-remote):ALL'
  - '+:(SW\DL_ADMIN_%{::hostname_upcase}):ALL'
  - "+:SW\\sa-qualys-linux:%{hiera('access_conf::qualys_ips')}"
  - "+:SW\\sa-cyberark-linux:%{hiera('access_conf::cyberark_ips')}" 
  - '-:ALL:ALL'
