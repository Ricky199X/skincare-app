class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get 'products/new' do
      authenticate
      erb :'products/new'
   end

   



end