class Item < ApplicationRecord
  self.inheritance_column = :no_column

  def format_price
    'R$' + price.to_s[0...-2] + ',' + price.to_s[-2..-1]
  end
end
