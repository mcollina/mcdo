class Item < ActiveRecord::Base

  validates :name, presence: true
  validates :list, presence: true

  attr_accessible :name

  belongs_to :list

  before_save :fill_position

  private

    def fill_position
      if new_record?
        self.position = list.items.last.try(:position).try(:+, 1) || 0
      end
    end

end
