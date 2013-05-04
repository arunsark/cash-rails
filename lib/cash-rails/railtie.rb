module CashRails
  class Railtie < ::Rails::Railtie
    initializer 'cashrails.initialize' do
      CashRails::Hooks.init
    end
  end
end
