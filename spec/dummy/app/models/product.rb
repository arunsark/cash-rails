class Product < ActiveRecord::Base
  attr_accessible :price_in_paise, :price

  casherize :price_in_paise
end
