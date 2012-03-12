require 'spec_helper'

describe "presence of" do
  before(:each) { visit('/texts.html') }

  describe "texts" do

    it "check single text" do
      see 'This is simple app'
    end

    it "many at once" do
      see 'and there is many lines',
          'in that app'
    end

    context "raise errors when" do
      it "text is not found" do
        expect do
          see 'This is simple app', 'and this line is not present'
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "links" do

    it "by text" do
      see :link => 'What you want'
    end

    it "by text and url" do
      see :link => {"What I need" => '/what-i/need'}
    end

    it "many at once" do
      see :links => ['What you want', {"What I need" => '/what-i/need', "What I have" => '/what-i/have'}]
    end

    context "raise errors when" do
      it "link text doesn't isn't present" do
        expect do
          see :links => "What I Would like"
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
      it "url for link is different" do
        expect do
          see :link => {"What I need" => '/what-i/have'}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "Elements" do
    context "defined by" do
      it "default selector type" do
        pending
        see :element => "#some_id"
      end

      it "explicit selector type" do
        pending
        see :element => [:xpath, ".//image[@id='some_id'"]
      end

      context "raise errors when" do
        it "element is not present" do
          pending
          expect do
            see :element => [:xpath, ".//image[@id='not_present'"]
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end
  end

  #! need to think do we need buttons (real buttons are only used in forms - all other buttons are just links with proper style)
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

end