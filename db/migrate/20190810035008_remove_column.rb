class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :routines, :product_id
  end
end
