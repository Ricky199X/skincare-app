class Product < ActiveRecord::Base
   belongs_to :routines
   has_many :users, through: :routines

end