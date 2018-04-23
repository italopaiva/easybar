class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_price(price)
    price_str = price.to_s

    price_str = "0#{price_str}" while price_str.length < 3

    'R$' + price_str[0...-2] + ',' + price_str[-2..-1]
  end
end
