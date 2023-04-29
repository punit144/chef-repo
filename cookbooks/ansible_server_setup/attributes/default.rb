default['audit']['reporter'] = %w(chef-server cli)
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['User pgrewal exists'] = {
    'name': 'User pgrewal exists',
    'compliance': 'admin/ansible-server-setup',
}
default['audit']['compliance_phase'] = true
