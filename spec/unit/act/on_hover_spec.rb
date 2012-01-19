require 'spec_helper'

describe '#on_hover' do
  before do
    Capybara.app = Hey.new('on_hover.html')
    @user = Kameleon::User::Guest.new(self)
  end

  pending do
    context 'trigger hover event on element' do
      it 'should trigger by css selector' do
        @user.on_hover('#second') do
          see 'Further information:'
          not_see 'Second option', 'First option'
        end
      end

      it 'should trigger by xpath selector' do
        @user.on_hover(:xpath, '//p[@id="second"]') do
          see 'Further information:'
          not_see 'Second option', 'First option'
        end
      end
    end

    context 'when element does not exist' do
      it 'should raise error' do
        expect do
          @user.on_hover('#doesNotExist') {}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
