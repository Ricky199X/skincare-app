class DropUserRoutines < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_routines
  end
end
