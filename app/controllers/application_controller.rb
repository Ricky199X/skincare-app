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

      def current_routine
         #should this be finding by an id, or finding by the routines name?
         clean_params = sanitize_data(params)
         Routine.find_by(id: clean_params[:id])
      end

      def authenticate
         if !logged_in?
            redirect '/login'
         else
            @user = current_user
            @routine = current_routine
            @user_routines = current_user.routines
            @user_products = current_user.products.all
         end
      end

      def authenticate_user(routine)
         redirect '/home' if !routine
         redirect '/home' if current_user != routine.user
      end

      def authenticate_product_user(product)
         redirect '/home' if !product
         redirect '/home' if current_user != product.users
      end

      def sanitize_data(params)
         clean_params = params.dup
         params.each do |key, value|
            clean_params[key] = Rack::Utils.escape_html(value)
         end
         clean_params
      end

      not_found do
         status 404
         erb :'errors/error404'
      end

      # def all_products
      #    return self.products.all
      # end

   end


end