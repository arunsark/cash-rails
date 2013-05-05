require "cashrb"
require 'cash-rails/version'
require "cash-rails/configuration"
require 'cash-rails/hooks'

module CashRails
end

if defined? Rails
  require "cash-rails/railtie"
  require "cash-rails/engine"
end
