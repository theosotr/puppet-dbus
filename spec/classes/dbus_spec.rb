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
        facts.merge({
          # FIXME
          :dbus_startup_provider => facts[:osfamily] == 'RedHat'     \
            ? ['5', '6'].include?(facts[:operatingsystemmajrelease]) \
              ? 'init'                                               \
              : 'systemd'                                            \
            : 'init',
        })
      end

      it { should contain_anchor('dbus::begin') }
      it { should contain_anchor('dbus::end') }
      it { should contain_class('dbus') }
      it { should contain_class('dbus::config') }
      it { should contain_class('dbus::install') }
      it { should contain_class('dbus::params') }
      it { should contain_class('dbus::reload') }
      it { should contain_class('dbus::service') }
      it { should contain_exec('dbus-send --system --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig') }
      it { should contain_file('/etc/dbus-1') }
      it { should contain_file('/etc/dbus-1/session.d') }
      it { should contain_file('/etc/dbus-1/session-local.conf') }
      it { should contain_file('/etc/dbus-1/system.d') }
      it { should contain_file('/etc/dbus-1/system-local.conf') }
      it { should contain_package('dbus') }

      case facts[:osfamily]
      when 'RedHat'
        case facts[:operatingsystemmajrelease]
        when '5', '6'
          it { should contain_service('messagebus').with_enable(true) }
        else
          it { should contain_service('dbus').without('enable') }
        end
        it { should contain_file('/etc/dbus-1/session.conf') }
        it { should contain_file('/etc/dbus-1/system.conf') }
      when 'Debian'
        it { should contain_service('dbus').with_enable(true) }
        it { should contain_file('/etc/dbus-1/session.conf') }
        it { should contain_file('/etc/dbus-1/system.conf') }
      when 'OpenBSD'
        it { should contain_service('messagebus').with_enable(true) }
        it { should contain_file('/usr/local/share/dbus-1/session.conf') }
        it { should contain_file('/usr/local/share/dbus-1/system.conf') }
      end
    end
  end
end
