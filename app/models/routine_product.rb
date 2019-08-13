class RoutineProduct < ActiveRecord::Base
  belongs_to :routines
  belongs_to :products
end