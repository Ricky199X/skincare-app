class User < ActiveRecord::Base
   has_secure_password
   has_many :routines
   has_many :products, through: :routine_products

   #validate user name, password, and email address
   validates :username, :email_address, :password, presence: true
   #validate uniqueness of username and email address
   validates :username, :email_address, uniqueness: true

   def slug
      username.downcase.gsub(" ", "-")
   end
  
   def self.find_by_slug(slug)
      self.all.find{|user| user.slug == slug}
   end
end