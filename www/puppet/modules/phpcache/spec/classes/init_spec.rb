require 'spec_helper'
describe 'phpcache' do

  context 'with defaults for all parameters' do
    it { should contain_class('phpcache') }
  end
end
