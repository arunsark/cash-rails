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
          postfix = CashRails::Configuration.cash_column_postfix.select { |postfix| subunit_name =~ /#{postfix}$/ }[0]
          if postfix
            name = subunit_name.sub(postfix, "")
          else
            name = subunit_name.sub(/_.+$/, "")
          end

          define_method name do |*args|
            amount = send(subunit_name, *args)

            memoized = instance_variable_get("@#{name}")
            return memoized if memoized && memoized.cents == amount
            unless amount.blank?
              if Cash.default_from == :cents
                amount = Cash.new(amount)
              else
                amount = Cash.new(amount / 100.0)
              end
            else
              amount = Cash.new(0)
            end
            instance_variable_set "@#{name}", amount
          end

          define_method "#{name}=" do |value|
            begin
              if value.is_a?(Cash)
                cash = value
              elsif Cash.default_from == :cents
                cash = Cash.new(value * 100)
              else
                cash = Cash.new(value)
              end
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
