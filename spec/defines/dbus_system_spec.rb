require 'spec_helper'

describe 'dbus::system' do

  let(:title) do
    'test'
  end

  let(:params) do
    {
      :content => '',
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'without dbus class included' do
        it { expect { should compile }.to raise_error(/must include the dbus base class/) }
      end

      context 'with dbus class included', :compile do
        let(:pre_condition) do
          'include ::dbus'
        end

        it { should contain_dbus__system('test') }
        it { should contain_file('/etc/dbus-1/system.d/test.conf') }
      end
    end
  end
end
