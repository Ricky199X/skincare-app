class AddColumnToRoutines < ActiveRecord::Migration[5.2]
  def change
    add_column :routines, :user_id, :integer
  end
end
