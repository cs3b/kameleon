require 'spec_helper'

#describe '#see special elements - buttons' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should see by id' do
#    @user.see :button => 'superButton'
#  end
#
#  it 'should see by label' do
#    @user.see :button => 'Super button'
#  end
#
#  it 'should see many buttons' do
#    @user.see :button => ['Super button', 'Second super button']
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.see :button => 'button does not exist'
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#describe '#see special elements - error message for' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/error_message_for.html')
#  end
#
#  it 'should see one messages' do
#    @user.see :error_message_for => 'name'
#  end
#
#  it 'should see many messages at once' do
#    @user.see :error_messages_for => ['name', 'title', 'content']
#  end
#
#  context 'when at least one does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.see :error_messages_for => ['name', 'doesNotExist']
#      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#describe '#see special elements - images' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should see by alt' do
#    @user.see :image => "Logo_diamondmine"
#  end
#
#  it 'should see by src' do
#    @user.see :image => "/images/logo_diamondmine.png?1324293836"
#  end
#
#  it 'should see many images' do
#    @user.see :images => ['Logo_diamondmine', 'Logo_redmine']
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.see :image => 'LinkDoesNotExist'
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
