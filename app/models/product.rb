class Product < ActiveRecord::Base
   has_many :routines, through: :routine_products
   has_many :users, through: :routines

end