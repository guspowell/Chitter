require 'bcrypt'

class User

  include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  property :id, Serial
  property :email, String, :unique => true
  property :username, String, :unique => true
  property :password_digest, Text

  has n, :posts

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user= first(:username => username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end

