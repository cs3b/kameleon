require 'spec_helper'

describe 'fill in attach file' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  it 'should attach file' do
    @user.will do
      see :empty => 'File input'
      fill_in :attach => { 'click.html' => 'Active File input' }
      see Kameleon::Utils::Helpers.default_path_for_file('click.html') => 'File input'
    end
  end

  context 'when disabled' do
    it 'should not attach file' do
      @user.will do
        see :empty => 'Disable File input'
        fill_in :attach => { 'click.html' => 'Disable File input' }
        see :empty => 'Disable File input'
      end
    end
  end

  context 'when file does not exist' do
    it 'should raise error' do
      expect do
        @user.will do
          fill_in :attach => { 'path' => 'Active File input' }
        end
      end.to_not raise_error(RuntimeError, %w{Sorry but we didn't found that file in: path'})
    end
  end
end
