require 'spec_helper'

describe '#not_see in scopes' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/scopes.html')
  end

  context '#will' do
    context 'when main selector was defined' do
      before { @user.stub!(:page_areas).and_return({:main => '#main'}) }

      it 'should not see in main selector scope' do
        @user.will do
          not_see 'Sample title for page', 'Sample text in footer'
        end
      end
    end
  end

  context '#within' do
    it 'should not see in css scope' do
      @user.within('#top h1') do
        not_see 'Sample text in top of page', 'Left side'
      end
    end

    context 'when scope by xpath' do
      it 'should not see in one selector scope' do
        @user.within(:xpath, '//div[@id="footer"]/span') do
          not_see 'Sample text in footer', 'Sample text in main part of page'
        end
      end

      it 'should not see in many selctors scope' do
        @user = Kameleon::User::Guest.new(self, :driver => :rack_test)
        @user.debug.visit('/scopes.html')
        @user.within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]', :select_multiple) do
          not_see 'Right side', 'Sample text in top of page', 'Sample text in footer'
        end
      end
    end

    context 'when scope by default selector type' do
      before do
        @user.stub!(:page_areas).and_return({:top => '#top',
                                             :footer => [:xpath, '//div[@id="footer"]']})
      end

      it 'should not see in top selector scope' do
        @user.within(:top) do
          not_see 'Sample text in main part of page', 'Sample text in footer'
        end
      end

      it 'should not see in footer selector scope' do
        @user.within(:footer) do
          not_see 'Sample title for page', 'Sample text in main part of page'
        end
      end
    end
  end
end
