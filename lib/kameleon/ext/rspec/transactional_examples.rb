#! TODO

RSpec.configure do |config|
  if defined? Rails
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
  end
  config.use_transactional_examples = true
end

require 'kameleon/ext/active_record/shared_single_connection'
