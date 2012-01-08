require 'spec_helper'

describe 'fill in attach file' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should attach file' do
    @user.will do
      see :empty => 'File input'
      full_path = "#{File.expand_path __FILE__ + '/../../../../dummy'}/click.html"
      fill_in :attach => { full_path => 'Active File input' }
      see full_path => 'Active File input'
    end
  end

  context 'when disabled' do
    it 'should not attach file' do
      @user.will do
        see :empty => 'Disable File input'
        fill_in :attach => { 'path' => 'Disable File input' }
        see :empty => 'Disable File input'
      end
    end
  end
end
