require 'spec_helper'
describe 'security_waf' do

  context 'with defaults for all parameters' do
    it {should contain_class('security_waf')}
  end
end
