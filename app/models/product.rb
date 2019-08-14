class Product < ActiveRecord::Base
   belongs_to :routine
   has_many :users, through: :routine

end