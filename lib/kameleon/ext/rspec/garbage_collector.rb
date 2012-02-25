require 'kameleon/ext/ruby/deferred_garbage_collector'

RSpec.configure do |config|
  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end