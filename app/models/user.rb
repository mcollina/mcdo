class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  def serializable_hash(*opts)
    result = super
    result.delete("password_digest")
    result
  end
end
