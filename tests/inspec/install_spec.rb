# Haproxy install

haproxy_package = 'haproxy'
haproxy_service = 'haproxy'

control 'install-01' do
  impact 1.0
  title 'Haproxy install'
  desc 'Haproxy should be installed'
  describe package(haproxy_package) do
    it { should be_installed }
  end
end

control 'install-02' do
  impact 1.0
  title 'Haproxy service'
  desc 'Haproxy should be enabled and started'
  describe service(haproxy_service) do
    it { should be_enabled }
    it { should be_running }
  end
end
