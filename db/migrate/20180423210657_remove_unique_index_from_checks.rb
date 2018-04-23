class RemoveUniqueIndexFromChecks < ActiveRecord::Migration[5.1]
  def change
    remove_index :checks, [:user_id, :open]
  end
end
