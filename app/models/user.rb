require 'bcrypt'

class User

  include DataMapper::Resource

  attr_writer :password_repeat
  attr_reader :password

  property :id,      Serial
  property :email,   String,  :required => true, :unique => true

  property :password_digest, String, length: 60

  validates_format_of :email, :as => :email_address
  validates_confirmation_of :password_digest, :confirm => :password_repeat


  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end


  private

  attr_reader :password_repeat

end
