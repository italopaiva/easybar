class AddItemIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :item, foreign_key: true
  end
end
