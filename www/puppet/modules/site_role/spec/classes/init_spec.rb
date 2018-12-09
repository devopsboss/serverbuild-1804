require 'spec_helper'
describe 'site_role' do
  context 'with default values for all parameters' do
    it { should contain_class('site_role') }
  end
end
