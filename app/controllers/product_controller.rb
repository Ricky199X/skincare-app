class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get '/products/new' do
      authenticate
      erb :'products/new'
   end

      post '/products' do
         if logged_in? && current_routine?
         @product = Product.create(name: params[:name], category: params[:category])
         @routine = current_routine?

         # 1. create a product 
         # 2. find a way to state what the current routine is 
         # 3. get the current_routines id 
         # 4. create an instance of a routine_product with current_routines id + product_id
         # 5. return user.products

         # binding.pry
            # binding.pry   
         # if routine is saved properly, go to the user's routines page
         # need to now associate a product with a routine.
         # through that association, we can associate the product with a user 
            redirect '/products' 
         else
            @message = "You made an oops! Add a new product!"
            erb :'products/new'
         end
      end

      get '/products/:id' do
         authenticate
         if current_user
            @product = Product.find(params[:id])
            erb :'/products/show'
         else
            redirect to '/login'
         end
      end

   



end