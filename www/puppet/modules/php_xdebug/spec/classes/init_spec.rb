require 'spec_helper'
describe 'phpxdebug' do

  context 'with defaults for all parameters' do
    it { should contain_class('phpxdebug') }
  end
end
