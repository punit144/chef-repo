#
# Cookbook:: ansible_server_setup
# Recipe:: ansible_2_9
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# Install epel-next-release package
if platform?('centos') && node['platform_version'].start_with?('8')
  # Install epel-next-release package
  package 'epel-release' do
    action :install
  end

  # Install required packages
  package %w(python3-pip python3-devel gcc)

  # Installing ansible dependency
  execute 'install setuptools-rust' do
    command 'sudo pip3 install setuptools-rust'
    not_if 'pip3 list | grep setuptools-rust'
  end
  # Upgrade Pip
  execute 'upgrade pip' do
    command 'sudo pip3 install --upgrade pip --quiet --disable-pip-version-check'
    not_if 'python -m pip list --format=freeze | grep "^pip==21."'
  end

  # Install Ansible 2.9.27 using pip3
  execute 'install ansible' do
    command 'sudo pip3 install ansible==2.9.27'
    not_if 'python -m pip list --format=freeze | grep "^ansible==2.9.27"'
  end

  # Display Ansible Version
  execute 'ansible version check' do
    command 'python -m pip list --format=freeze | grep ansible'
    live_stream true
  end
end
