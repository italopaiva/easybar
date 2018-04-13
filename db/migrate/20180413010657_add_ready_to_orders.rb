class AddReadyToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ready, :boolean, default: false
  end
end
