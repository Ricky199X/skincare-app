class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   # get '/products/new' do
   #    authenticate
   #    @routine = Routine.find_by(id: params[:id])

   #    redirect to "/routines/:id/products/new"
   #    # redirect to '/routines/:id/products'
   # end
   
   get "/routines/:id/products/new" do
      authenticate
      @routine = Routine.find_by(id: params[:id])
      erb :'products/new'
   end


   post "/routines/:id/products" do
      if current_user
         @routine = Routine.find_by(id: params[:id])
         @product = Product.create(name: params[:product][:name], category: params[:product][:category])
         
         redirect "/routines/#{@routine.id}"
      end
   end



      #    if logged_in? 
      #       # && current_user
      #    # current_routine
      #    # binding.pry
      #    # routine = @user_routines.find_by(id: params[:id])
      #    # @routine.save
      #    # binding.pry
      #    #verify routine.user == current_user
      #    @product = Product.create(name: params[:product][:name], category: params[:product][:category])
      #    # routine.products << @product
      #    binding.pry  
      #    # current_routine.products << @product
         


      #    # routine/2/product/new


      #    # 1. create a product 
      #    # 2. find a way to state what the current routine is 
      #    # 3. get the current_routines id 
      #    # 4. create an instance of a routine_product with current_routines id + product_id
      #    # 5. return user.products

      #    # binding.pry
      #       # binding.pry   
      #    # if routine is saved properly, go to the user's routines page
      #    # need to now associate a product with a routine.
      #    # through that association, we can associate the product with a user 
      #       redirect 'routines/:id'
      #    else
      #       @message = "You made an oops! Add a new product!"
      #       erb :'products/new'
      #    end
      # end
      
   

      get '/products/:id' do
         authenticate
         if current_user
            @product = Product.find(params[:id])
            erb :'/products/show'
         else
            redirect to '/login'
         end
      end

      # delete product action
      delete '/products/:id' do
         authenticate
         @product = Product.find_by(id: params[:id])
         if @product
            @product.destroy
            redirect '/products'
         end
      end
   

end