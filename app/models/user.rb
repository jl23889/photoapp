class User
  include Mongoid::Document
  field :username
  field :password
  field :password_confirmation

  validates_presence_of :username, :password
  validates_uniqueness_of :username
  validates_confirmation_of :password
  has_many :photos

  def self.authenticate(username, password)
  	user = User.find_by(username: username)
  	if user && password == user.password
  		user
  	else
  		nil
  	end
  end
end
