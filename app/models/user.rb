class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation

  before_create :create_new_list
  
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  has_and_belongs_to_many :lists, order: "updated_at DESC"

  def serializable_hash(*opts)
    result = super
    result.delete("password_digest")
    result
  end

  private

    def create_new_list
      self.lists << List.new(name: "Personal")
    end
end
