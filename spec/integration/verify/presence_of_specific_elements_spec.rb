require 'spec_helper'

describe "presence of specific elements" do
  before(:each) { load_page('/special_elements') }

  describe "image" do
    it "by alt attribute" do
      see :image => "Logo_diamondmine"
    end

    it "by src attribute" do
      see :image => "/images/logo_diamondmine.png?1324293836"
    end

    it "many at once" do
      see :images => ['Logo_diamondmine', 'Logo_redmine', "/images/logo_diamondmine.png?1324293836"]
    end

    context "raise errors when" do
      it "haven't found image with alt" do
        expect do
          see :image => 'NoImageWithThatAlt'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "haven't found image with src" do
        expect do
          see :images => ['Logo_redmine', "/images/logo_selleo_com.png"]
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  #! it is very rails specific (not sure if this should be here)
  # describe "error messages" do
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
  # end
end