class ApplicationController < Sinatra::Base

   configure do 
      set :views, 'app/views'
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, SESSION_SECRET
   end

   get '/' do
      erb :index
   end

   get '/home' do
      authenticate
      erb :home
   end


   helpers do
      #if user id is nil, I will not be logged in, if not nil I am logged in
      def logged_in? 
         !!session[:user_id]
      end

      def current_user
         User.find_by(id: session[:user_id])
      end

      def authenticate
         if !logged_in?
            redirect '/login'
         else
            @user = current_user
            @user_routines = current_user.routines
         end
      end

      def authenticate_user(routine)
         redirect '/home' if !routine
         redirect '/home' if current_user != routine.user
      end

   end


end