require 'spec_helper'

describe '#see counted elements' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/elements_counter.html')
  end

  context 'when page areas has attribute' do
    before do
      @user.stub!(:page_areas).and_return(:menu_link => [:xpath, '//ul[@id="menu"]/li/a'])
    end

    it 'should counted elements from page areas attribute' do
      @user.see 7 => :menu_link
    end
  end

  it "should see counted elements from css" do
    @user.see 5 => '#fiveElements'
  end

  it 'should see counted elements from xpath' do
    @user.see 5 => [:xpath, '//div[@id="fiveElements"]']
  end
end
