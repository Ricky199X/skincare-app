class RoutineController < ApplicationController

   get '/routines' do
      authenticate
      @routines = Routine.all
      erb :'routines/index'
   end

   get '/routines/new' do
      authenticate
      erb :'routines/new'
   end

end