# bungaku_version_spec.rb - checks for existance of Bungaku::VERSION
require_relative  'spec_helper'



describe Bungaku do
  it 'should have a version' do
    Bungaku::VERSION.wont_be_nil
  end
end
