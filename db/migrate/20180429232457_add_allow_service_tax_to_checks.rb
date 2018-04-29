class AddAllowServiceTaxToChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :checks, :allow_service_tax, :boolean, default: true
  end
end
