class CreateRoutineProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :routine_products do |t|
      t.integer :routine_id
      t.integer :product_id
    end
  end
end
