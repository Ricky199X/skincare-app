class RoutineController < ApplicationController

   get '/routines' do
      authenticate
      erb :'routines/index'
   end

end