class RoutineProduct < ActiveRecord::Base
  has_many :routines
  has_many :products
end