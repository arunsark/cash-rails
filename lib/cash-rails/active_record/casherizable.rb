require 'active_support/concern'
require 'active_support/core_ext/array/extract_options'
require 'active_support/deprecation/reporting'

module CashRails
  module ActiveRecord
    module Casherizable
      extend ActiveSupport::Concern

      module ClassMethods
        def casherize(field, *args)
          subunit_name = field.to_s
          name = subunit_name.sub(/_.+$/, "")

          define_method name do |*args|
            amount = send(subunit_name, *args)

            memoized = instance_variable_get("@#{name}")
            return memoized if memoized && memoized.cents == amount
            amount = Cash.new(amount) unless amount.blank?
            instance_variable_set "@#{name}", amount
          end

          define_method "#{name}=" do |value|
            begin
              cash = value.is_a?(Cash) ? value : Cash.new(value * 100)
            rescue NoMethodError
              return nil
            end
            send("#{subunit_name}=", cash.try(:cents))
            instance_variable_set "@#{name}", cash
          end
        end
      end
    end
  end
end
