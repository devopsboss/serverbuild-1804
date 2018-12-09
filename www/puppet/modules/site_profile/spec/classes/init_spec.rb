require 'spec_helper'
describe 'site_profile' do
  context 'with default values for all parameters' do
    it { should contain_class('site_profile') }
  end
end
