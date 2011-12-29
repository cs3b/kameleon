# encoding: utf-8
require 'spec_helper'

describe 'see spcial elements' do

  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'links' do
    it 'proper link' do
      @user.see :link => {'What you want' => '/i-want/to'}
    end

    context 'link is not found' do
      it 'will fail' do
        expect do
          @user.see :link => {'What I need' => '/no-way'}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'images' do
    it 'see by alt' do
      @user.see :image => "Logo_diamondmine"
    end

    it 'see by src' do
      @user.see :image => "/images/logo_diamondmine.png?1324293836"
    end
  end

  context 'text in proper order on page' do
    it 'see in proper order' do
      @user.see :ordered => ['Michał Czyż', 'Tomasz Bąk', 'Rafał Bromirski']
    end

    context 'incorrect order' do
      it "will fail" do
        expect do
          @user.see :ordered => ['Tomasz Bąk', 'Michał Czyż', 'Rafał Bromirski']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
