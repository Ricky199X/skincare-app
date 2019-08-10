class User < ActiveRecord::Base
   has_many :routines
   has_many :products, through: :routines

   #validate user name, password, and email address
   validates :username, :password, :email, presence: true

   #validate uniqueness of username
   validates :username, uniqueness: true

   def slug
      username.downcase.gsub(" ", "-")
   end
  
   def self.find_by_slug(slug)
      self.all.find{|user| user.slug == slug}
   end
end