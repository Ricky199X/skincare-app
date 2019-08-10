class AddProductIdToRoutines < ActiveRecord::Migration[5.2]
  def change
    add_column :routines, :product_id, :integer
  end
end
