module CashRails
  class Hooks
    def self.init
      # For Active Record
      ActiveSupport.on_load(:active_record) do
        require 'cash-rails/active_record/casherizable'
        ::ActiveRecord::Base.send :include, CashRails::ActiveRecord::Casherizable
      end
    end
  end
end
