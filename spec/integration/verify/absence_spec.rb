require 'spec_helper'

#describe '#not_see special selectors in tables' do
#
#  context 'when in row' do
#    before do
#      @user = Kameleon::User::Guest.new(self)
#      @user.debug.visit('/special_elements.html')
#    end
#    it 'should not see text' do
#      @user.within(:row => 'Michal Czyz') do
#        not_see "17"
#      end
#    end
#  end
#
#  context 'when in column' do
#    before do
#      @user = Kameleon::User::Guest.new(self, {:driver => :rack_test})
#      @user.debug.visit('/special_elements.html')
#    end
#    context 'when scoped by full text' do
#      it 'should not see text' do
#        @user.within(:column => 'Selleo') do
#          not_see "19.00", "17.00", "5.00"
#        end
#      end
#    end
#
#    context 'when scoped by partial text' do
#      it 'should not see text' do
#        @user.within(:column => 'lleo') do
#          not_see "19.00", "17.00", "5.00"
#        end
#      end
#    end
#  end
#end

#
#describe '#not_see texts' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/texts.html')
#  end
#
#  it 'should not see single text' do
#    @user.not_see 'cool rails app'
#  end
#
#  it 'should not see many texts at once' do
#    @user.not_see 'sinatra app', 'padrino app'
#  end
#
#  context 'when at least one text is visibile' do
#    it 'should raise error' do
#      expect do
#        @user.not_see 'sinatra app', 'This is simple app'
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see form elements - fields' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should not see by label' do
#    @user.not_see :field => 'maybeDiv'
#  end
#
#  it 'should not see many at once' do
#    @user.not_see :fields => ['maybeDiv', 'maybeSecondDiv']
#  end
#
#  context 'when at least one exists' do
#    it 'should raise error' do
#      expect do
#        @user.not_see :field => ['maybeDiv', 'multiSelect']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see form elements - textareas' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should not see one' do
#    @user.not_see 'another this is great value' => 'textarea3'
#  end
#
#  it 'should not see many at once' do
#    @user.not_see 'other this is great value' => 'secondTextarea2',
#                  'other sample default value' => 'textarea3'
#  end
#
#  context 'when exists' do
#    it 'should raise error' do
#      expect do
#        @user.not_see 'sample text in second textarea 2' => 'secondTextarea2'
#      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see form elements - text inputs' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should not see one' do
#    @user.not_see 'sample other value' => 'maybeSimpleDiv'
#  end
#
#  it 'should not see many at once' do
#    @user.not_see 'other this is great value' => 'maybeSimpleDiv',
#                  'other sample default value' => 'maybeSimpleDiv'
#  end
#
#  context 'when exists' do
#    it 'should raise error' do
#      expect do
#        @user.not_see 'sample default value' => 'secondInput',
#                      'sample value' => 'maybeSimpleDiv'
#      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see special elements - buttons' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should not see one button' do
#    @user.not_see :button => 'first'
#  end
#
#  it 'should not see many buttons' do
#    @user.not_see :button => ['first button', 'second button']
#  end
#
#  context 'when exists' do
#    it 'should raise error' do
#      expect do
#        @user.not_see :button => 'Super button'
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see special elements - error message for' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/error_message_for.html')
#  end
#
#  it 'should not see one messages' do
#    @user.not_see :error_message_for => 'first field'
#  end
#
#  it 'should not see many messages at once' do
#    @user.not_see :error_messages_for => ['first field', 'second field']
#  end
#
#  context 'when at least one exist' do
#    it 'should raise error' do
#      expect do
#        @user.not_see :error_messages_for => ['name', 'doesNotExist']
#      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see special elements - images' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should not see one image' do
#    @user.not_see :image => 'sample_first'
#  end
#
#  it 'should not see many images' do
#    @user.not_see :images => ['sample_first', 'sample_second']
#  end
#
#  context 'when at least one exists' do
#    it 'should raise error' do
#      expect do
#        @user.not_see :image => ['sample_first', 'Logo_diamondmine']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end

#
#describe '#not_see special elements - links' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  context 'when src is provided' do
#    it 'should not see one link' do
#      @user.not_see :link => { 'Maybe div' => '/i/do/not/know' }
#    end
#
#    it 'should not see many links' do
#      @user.not_see :links => { 'Maybe div' => '/i/do/not/know',
#                                'Maybe other div' => '/i/do/not/know/too' }
#    end
#
#    context 'when at least one exists' do
#      it 'should raise error' do
#        expect do
#          @user.not_see :link => { 'What you want' => '/i-want/to',
#                                   'Maybe div' => '/i/do/not/know' }
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#  end
#
#  context 'when src path is not provided' do
#    it 'should not see one link' do
#      @user.not_see :link => 'Maybe div'
#    end
#
#    it 'should not see many links' do
#      @user.not_see :links => ['Maybe div', 'Maybe other div']
#    end
#
#    context 'when at least one exists' do
#      it 'should raise error' do
#        expect do
#          @user.not_see :link => ['What you want', 'Maybe div']
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#  end
#end
#
#describe '#not_see special elements - ordered texts' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should not see text in proper order' do
#    @user.not_see :ordered => ['Tomasz Bak', 'Michal Czyz', 'Rafal Bromirski']
#  end
#
#  context 'when texts is in proper order' do
#    it 'should raise error' do
#      expect do
#        @user.not_see :ordered => ['Michal Czyz', 'Tomasz Bak', 'Rafal Bromirski']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
