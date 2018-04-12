class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
