class CreateRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :routines do |t|
      t.string :name
      t.string :description
      t.text :products
      t.integer :user_id
    end
  end
end
