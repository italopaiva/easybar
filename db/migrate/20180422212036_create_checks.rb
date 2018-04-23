class CreateChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :checks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :table, foreign_key: true, null: false
      t.boolean :open, null: false, default: false

      t.timestamps
    end
  end
end
