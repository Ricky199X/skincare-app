class UserRoutine < ActiveRecord::Base
   has_many :users
   has_many :routines
end