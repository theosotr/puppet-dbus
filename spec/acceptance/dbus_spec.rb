require 'spec_helper_acceptance'

describe 'dbus' do

  case fact('osfamily')
  when 'RedHat'
    group        = 'root'
    session_conf = '/etc/dbus-1/session.conf'
    system_conf  = '/etc/dbus-1/system.conf'
    service      = 'messagebus'
  when 'Debian'
    group        = 'root'
    session_conf = '/etc/dbus-1/session.conf'
    system_conf  = '/etc/dbus-1/system.conf'
    service      = 'dbus'
  when 'OpenBSD'
    group        = 'wheel'
    session_conf = '/usr/local/share/dbus-1/session.conf'
    system_conf  = '/usr/local/share/dbus-1/system.conf'
    service      = 'messagebus'
  end

  it 'should work with no errors' do

    pp = <<-EOS
      Package {
        source => $::osfamily ? {
          'OpenBSD' => "http://ftp.openbsd.org/pub/OpenBSD/${::operatingsystemrelease}/packages/${::architecture}/",
          default   => undef,
        },
      }

      include ::dbus
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end

  describe package('dbus') do
    it { should be_installed }
  end

  describe file('/etc/dbus-1') do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into group }
  end

  describe file(session_conf) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into group }
    its(:content) { should match /busconfig/ }
  end

  describe file('/etc/dbus-1/session-local.conf') do
    it { should_not exist }
  end

  describe file('/etc/dbus-1/session.d') do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into group }
  end

  describe file(system_conf) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into group }
    its(:content) { should match /busconfig/ }
  end

  describe file('/etc/dbus-1/system-local.conf') do
    it { should_not exist }
  end

  describe file('/etc/dbus-1/system.d') do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into group }
  end

  describe service(service) do
    it { should be_enabled }
    it { should be_running }
  end
end
