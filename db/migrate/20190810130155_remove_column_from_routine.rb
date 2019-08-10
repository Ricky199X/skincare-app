class RemoveColumnFromRoutine < ActiveRecord::Migration[5.2]
  def change
    remove_column :routines, :products
  end
end
