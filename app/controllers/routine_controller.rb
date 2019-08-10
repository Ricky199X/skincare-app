class RoutineController < ApplicationController

   get '/routines' do
      if logged_in?
         erb :'routines/index'
      else
         "Go away"
      end
   end

end