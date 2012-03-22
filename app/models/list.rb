class List < ActiveRecord::Base

  validates :name, presence: true

  has_and_belongs_to_many :users

  has_many :items

  before_create :create_new_item

  private

    def create_new_item
      self.items << Item.new(name: "Insert your items!")
    end
end
