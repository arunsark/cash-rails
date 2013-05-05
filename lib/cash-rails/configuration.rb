module CashRails
  module Configuration
    def self.cash_column_postfix
      %w(_in_cents _cents _in_paise _paise)
    end
  end
end
