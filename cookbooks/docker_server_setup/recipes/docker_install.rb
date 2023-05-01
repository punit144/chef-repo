# This recipe is to install docker on Centos Stream 8
# Update the package manager
execute 'update core plugins of centos stream 8' do
  command 'dnf install dnf-plugins-core -y'
  not_if 'rpm -q dnf-plugins-core'
end

# Add Docker repository
execute 'add Docker repository' do
  command 'dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo'
  not_if 'dnf repolist | grep docker-ce'
end

# Install Docker packages using a loop
node['docker_packages'].each do |pkg|
  package pkg do
    action :install
    options '--allowerasing'
  end
end

# Start and enable Docker service
service 'docker' do
  action [:start, :enable]
end

# Download Docker Compose binary
execute 'download docker-compose binary' do
  command 'curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
  not_if { ::File.exist?('/usr/local/bin/docker-compose') }
end

# Make Docker Compose binary executable
execute 'make docker-compose executable' do
  command 'chmod +x /usr/local/bin/docker-compose'
  not_if 'test -x /usr/local/bin/docker-compose'
end
