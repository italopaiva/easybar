class Check < ApplicationRecord
  belongs_to :user
  belongs_to :table

  has_many :orders

  scope :closed, (-> { where(open: false) })

  SERVICE_TAX = 10

  def can_close?
    !orders.pluck(:ready).include?(false)
  end

  def total_price
    sum = 0

    orders.each do |order|
      sum += order.final_price if order.active
    end

    sum
  end

  def formatted_total_price
    format_price(total_price)
  end

  def service_tax
    total_price * SERVICE_TAX / 100
  end

  def formatted_service_tax
    format_price(service_tax)
  end

  def final_price
    if allow_service_tax?
      total_price + service_tax
    else
      total_price
    end
  end

  def formatted_final_price
    format_price(final_price)
  end
end
