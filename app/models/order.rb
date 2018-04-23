class Order < ApplicationRecord
  belongs_to :user
  belongs_to :check
  belongs_to :item

  has_many :order_items
  has_many :items, through: :order_items

  def ordered_at
    created_at.strftime('%d/%m/%Y - %H:%Mh')
  end
end
