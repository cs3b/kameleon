#! TODO need to be tested

if defined? Spork

  Spork.prefork do
    ActiveRecord::Base.connection_handler.clear_active_connections!
    ActiveRecord::Base.connection.disconnect!

    class ActiveRecord::Base
      mattr_accessor :shared_connection
      @@shared_connection = nil

      def self.connection
        @@shared_connection || retrieve_connection
      end
    end
  end

  Spork.each_run do
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.retrieve_connection
  end

else

  ActiveRecord::Base.connection_handler.clear_active_connections!
  ActiveRecord::Base.connection.disconnect!


  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end

  ActiveRecord::Base.establish_connection
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.retrieve_connection

end