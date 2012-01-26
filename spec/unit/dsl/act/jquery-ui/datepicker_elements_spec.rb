require 'spec_helper'

describe '#select date from datepicker elements' do
  before do
    Capybara.app = Hey.new('autocomplete.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should select many date at once' do
   @user.see :empty => ['datepicker', 'secondDatepicker']
   @user.select_date '12-12-2012' => 'datepicker', '01-01-2012' => 'secondDatepicker'
   @user.see '12/12/2012' => 'datepicker', '01/01/2012' => 'secondDatepicker'
  end

  context 'when date is in format "dd-mm-yyyy"' do
    it 'should select date by id' do
      @user.see :empty => 'datepicker'
      @user.select_date '12-12-2012' => 'datepicker'
      @user.see '12/12/2012' => 'datepicker'
    end

    it 'should select date by label' do
      @user.see :empty => 'datepicker'
      @user.select_date '12-12-2012' => 'Select datepicker'
      @user.see '12/12/2012' => 'datepicker'
    end
  end

  context 'when date is in format "dd/mm/yyyy"' do
    it 'should select date by id' do
      @user.see :empty => 'datepicker'
      @user.select_date '12/12/2012' => 'datepicker'
      @user.see '12/12/2012' => 'datepicker'
    end

    it 'should select date by label' do
      @user.see :empty => 'datepicker'
      @user.select_date '12/12/2012' => 'Select datepicker'
      @user.see '12/12/2012' => 'datepicker'
    end
  end

  context 'when date is in format "day short_month_name year"' do
    it 'should select date by id' do
      @user.see :empty => 'datepicker'
      @user.select_date '1 jan 2012' => 'datepicker'
      @user.see '01/01/2012' => 'datepicker'
    end

    it 'should select date by label' do
      @user.see :empty => 'datepicker'
      @user.select_date '1 jan 2012' => 'Select datepicker'
      @user.see '01/01/2012' => 'datepicker'
    end
  end

  context 'when date is in format "day full_month_name year"' do
    it 'should select date by id' do
      @user.see :empty => 'datepicker'
      @user.select_date '1 january 2012' => 'datepicker'
      @user.see '01/01/2012' => 'datepicker'
    end

    it 'should select date by label' do
      @user.see :empty => 'datepicker'
      @user.select_date '1 january 2012' => 'Select date'
      @user.see '01/01/2012' => 'datepicker'
    end
  end

  context 'when datepicker is disabled' do
    it 'should not select date by id' do
      @user.see :empty => 'disabledDatepicker'
      @user.select_date '01-01-2012' => 'disabledDatepicker'
      @user.see :empty => 'disabledDatepicker'
    end

    it 'should not select date by label' do
      @user.see :empty => 'disabledDatepicker'
      @user.select_date '01-01-2012' => 'Disabled datepicker'
      @user.see :empty => 'disabledDatepicker'
    end
  end

  context 'when field with datepicker is disabled' do
    it 'should not select date by id' do
      @user.see :empty => 'datepickerInDisabledInput'
      @user.select_date '01-01-2012' => 'datepickerInDisabledInput'
      @user.see :empty => 'datepickerInDisabledInput'
    end

    it 'should not select date by label' do
      @user.see :empty => 'datepickerInDisabledInput'
      @user.select_date '01-01-2012' => 'Datepicker in disabled input'
      @user.see :empty => 'datepickerInDisabledInput'
    end
  end

  context 'when field does not exist' do
    it 'should raise error' do
      expect do
        @user.select_date '01-01-2012' => 'elementDoesNotExist'
      end.to raise_error(Capybara::ElementNotFount)
    end
  end

  context 'when date for datepicker is wrong' do
    it 'should not select date from datepicker' do
      @user.see :empty => 'datepicker'
      @user.select_date '555-01-2012' => 'Datepicker in disabled input'
      @user.see :empty => 'datepicker'
    end
  end

  context 'when element is not datepicker' do
    it 'should not fill input' do
      @user.see :empty => 'sampleOther'
      @user.select_date '12-12-2012' => 'sampleOther'
      @user.see :empty => 'sampleOther'
    end
  end
end
