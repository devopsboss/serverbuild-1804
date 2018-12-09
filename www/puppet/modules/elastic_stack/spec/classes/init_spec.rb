require 'spec_helper'
describe 'elastic_apm' do

  context 'with defaults for all parameters' do
    it { should contain_class('elastic_apm') }
  end
end
