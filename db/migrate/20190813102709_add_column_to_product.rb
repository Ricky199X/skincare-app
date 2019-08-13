class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :routine_id, :integer
  end
end
