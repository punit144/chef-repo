#
# Cookbook:: ansible_server_setup
# Recipe:: ansible_2_9
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# Install epel-next-release package
if platform?('centos') && node['platform_version'].start_with?('8.')
  # Install epel-next-release package
  package 'epel-release' do
    action :install
  end

  # Install ansible package
  package 'ansible-2.9.27' do
    action :install
  end

  # Print success message
  ruby_block 'print_success_message' do
    block do
      Chef::Log.info('Ansible and EPEL release have been successfully installed.')
    end
    action :run
  end
end
