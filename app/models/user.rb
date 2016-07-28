require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, format: :email_address, unique: true, required: true
  property :password_digest, String, length: 60

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  # Unnecessary validations, since above we have[ property :email, required: true ]
  #validates_presence_of :email
  #validates_format_of :email, as: :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
