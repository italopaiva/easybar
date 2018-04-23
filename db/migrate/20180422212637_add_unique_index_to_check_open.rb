class AddUniqueIndexToCheckOpen < ActiveRecord::Migration[5.1]
  def change
    add_index :checks, [:user_id, :open], unique: true
  end
end
