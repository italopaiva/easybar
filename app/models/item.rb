class Item < ApplicationRecord
  self.inheritance_column = :no_column

  scope :drinks, (->() { where(type: :drink) })
  scope :foods, (->() { where(type: :food) })
  scope :snacks, (->() { where(type: :snack) })
  scope :narguiles, (->() { where(type: :narguile) })

  def format_price
    'R$' + price.to_s[0...-2] + ',' + price.to_s[-2..-1]
  end
end
