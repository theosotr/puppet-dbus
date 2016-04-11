require 'spec_helper'

describe 'dbus' do

  context 'on unsupported distributions' do
    let(:facts) do
      {
        :osfamily => 'Unsupported'
      }
    end

    it { expect { should compile }.to raise_error(/not supported on an Unsupported/) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}", :compile do
      let(:facts) do
        facts
      end

      it { should contain_anchor('dbus::begin') }
      it { should contain_anchor('dbus::end') }
      it { should contain_class('dbus') }
      it { should contain_class('dbus::config') }
      it { should contain_class('dbus::install') }
      it { should contain_class('dbus::params') }
      it { should contain_class('dbus::service') }
      it { should contain_file('/etc/dbus-1') }
      it { should contain_file('/etc/dbus-1/session.d') }
      it { should contain_file('/etc/dbus-1/session-local.conf') }
      it { should contain_file('/etc/dbus-1/system.d') }
      it { should contain_file('/etc/dbus-1/system-local.conf') }
      it { should contain_package('dbus') }

      case facts[:osfamily]
      when 'RedHat'
        it { should contain_service('messagebus') }
        it { should contain_file('/etc/dbus-1/session.conf') }
        it { should contain_file('/etc/dbus-1/system.conf') }
      when 'Debian'
        it { should contain_service('dbus') }
        it { should contain_file('/etc/dbus-1/session.conf') }
        it { should contain_file('/etc/dbus-1/system.conf') }
      when 'OpenBSD'
        it { should contain_service('messagebus') }
        it { should contain_file('/usr/local/share/dbus-1/session.conf') }
        it { should contain_file('/usr/local/share/dbus-1/system.conf') }
      end
    end
  end
end
