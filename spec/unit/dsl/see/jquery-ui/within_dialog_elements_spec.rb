require 'spec_helper'

describe '#within dialog elements' do
  before do
    Capybara.app = Hey.new('dialog.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should scoping by dialog title' do
    @user.within(:dialog => 'First dialog') do
      see 'Sample text in dialog'
      not_see 'Page with dialogs', 'Sample text in footer'
    end
  end

  it 'should scoping by dialog id' do
    @user.within(:dialog => 'dialog') do
      see 'Sample text in dialog'
      not_see 'Page with dialogs', 'Sample text in footer'
    end
  end

  it 'should scoping by many dialogs at once' do
    @user.within(:dialogs => %w(dialog secondDialog)) do
      see 'Sample text in dialog', 'Great text in second dialog'
      not_see 'Sample text in footer', 'Page with dialogs'
    end
  end

  context 'when dialog is closed already' do
    it 'should scoping by empty dialog' do
      @user.within(:dialog => 'closedDialog') do
        not_see 'Nice text in closed dialog', 'Page with dialogs',
                'Sample text in dialog'
      end
    end
  end

  context 'when element is not dialog' do
    it 'should raise error' do
      expect do
        @user.within(:dialog => 'footer') {}
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when dialog does not exist' do
    it 'should raise error' do
      expect do
        @user.within(:dialog => 'doesNotExist') {}
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
