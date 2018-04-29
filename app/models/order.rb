class Order < ApplicationRecord
  belongs_to :user
  belongs_to :check
  belongs_to :item

  has_many :order_items
  has_many :items, through: :order_items

  scope :for_table, (lambda do |table_id|
    joins(:check).where(checks: { table_id: table_id })
  end)

  scope :order_for_admin, (lambda do
    order('checks.open DESC')
      .order(ready: :asc)
      .order(active: :asc)
      .order(created_at: :asc)
  end)

  def ordered_at
    created_at.strftime('%d/%m/%Y - %H:%Mh')
  end

  def formatted_final_price
    format_price(final_price)
  end

  def final_price
    quantity * item.price
  end
end
