class AddCheckToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :check, foreign_key: true
  end
end
