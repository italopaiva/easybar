class Check < ApplicationRecord
  belongs_to :user
  belongs_to :table

  has_many :orders

  scope :closed, (-> { where(open: false) })

  def can_close?
    !orders.pluck(:ready).include?(false)
  end

  def total_price
    sum = 0

    orders.each do |order|
      sum += order.final_price
    end

    sum
  end

  def formatted_total_price
    format_price(total_price)
  end
end
