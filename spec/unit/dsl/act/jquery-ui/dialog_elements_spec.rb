require 'spec_helper'

describe '#close dialog elements' do
  before do
    Capybara.app = Hey.new('dialog.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should close dialog by id' do
    @user.within(:dialog => 'dialog') { see 'Sample text in dialog' }
    @user.close :dialog => 'dialog'
    @user.within(:dialog => 'dialog') { not_see 'Sample text in dialog' }
  end

  it 'should close dialog by title' do
    @user.within(:dialog => 'dialog') { see 'Sample text in dialog' }
    @user.close :dialog => 'First dialog'
    @user.within(:dialog => 'dialog') { not_see 'Sample text in dialog' }
  end

  it 'should close many dialogs at once' do
    @user.within(:dialogs => %w(dialog secondDialog)) do
      see 'Sample text in dialog', 'Great text in second dialog'
    end

    @user.close :dialogs => %w(dialog secondDialog)

    @user.within(:dialogs => %w(dialog secondDialog)) do
      not_see 'Sample text in dialog', 'Great text in second dialog'
    end
  end

  context 'when dialog is closed already' do
    it 'should raise error' do
      expect do
        @user.close :dialog => 'closedDialog'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element is not dialog' do
    it 'should raise error' do
      expect do
        @user.close :dialog => 'footer'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.close :dialog => 'doesNotExist'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
