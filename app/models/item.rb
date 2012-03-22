class Item < ActiveRecord::Base

  validates :name, presence: true
  validates :list, presence: true

  attr_accessible :name

  belongs_to :list

end
