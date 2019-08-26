class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get '/products' do
      authenticate
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
      redirect to '/routines/:id/products'
   end

   get '/products/:id' do
      authenticate
      clean_params = sanitize_data(params)
      if current_user
         @product = Product.find(clean_params[:id])
         authenticate_product_user(@product)
         erb :'/products/show'
      else
         redirect to '/login'
      end
   end

   # product edit action
   get '/products/:id/edit' do
      clean_params = sanitize_data(params)
      @product = Product.find_by(id: clean_params[:id])
      authenticate_product_user(@product)
      if @product
         erb :'/products/edit'
      else
         redirect to 'products'
      end
   end

   patch '/products/:id' do
      clean_params = sanitize_data(params)
      @product = Product.find_by(id: clean_params[:id])
         authenticate_product_user(@product)
         @product.update(name: clean_params[:name], category: clean_params[:category])
         # needs to redirect back to the current routine
         redirect '/products'
   end

   # delete product action
   delete '/products/:id' do
      authenticate
      clean_params = sanitize_data(params)
      @product = Product.find_by(id: clean_params[:id])
      authenticate_product_user(@product)
      if @product
         @product.destroy
         redirect '/products'
      end
   end
   

end