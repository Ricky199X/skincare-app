class User < ActiveRecord::Base
   has_secure_password
   has_many :routines
   # has_many :routine_products, through: :routines
   # has_many :products, through: :routine_products
   has_many :products, through: :routines
   #validate user name, password, and email address
   validates :username, :email_address, presence: true
   validates :password, presence: true, on: :create
   #validate uniqueness of username and email address
   validates :username, :email_address, uniqueness: true
   # length validation for password - must be at least 4 characters
   validates :password, length: {in: 4..10}, unless: ->(u){ u.password.blank? }


   def slug
      username.downcase.gsub(" ", "-")
   end
  
   def self.find_by_slug(slug)
      self.all.find{|user| user.slug == slug}
   end
end