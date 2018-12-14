# Haproxy install

haproxy_package = 'haproxy'

control 'install-01' do
  impact 1.0
  title 'Haproxy install'
  desc 'Haproxy should be installed'
  describe package(haproxy_package) do
    it { should be_installed }
  end
end
