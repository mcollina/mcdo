class List < ActiveRecord::Base

  validates :name, presence: true

  has_and_belongs_to_many :users

  has_many :items, order: "position ASC"

  before_create :create_new_item

  def move(args)
    # we get the current item
    item = items.find(args[:item_id])
    return unless item

    # delete the item from the items list
    items.delete_if { |i| i.id == item.id }

    # insert the item at the new position
    items.insert(args[:position].to_i, item)

    # redefine the position of all items
    items.inject(0) do |acc, i|
      if i
        i.position = acc
        i.save
        acc + 1
      else
        # this ack is done to fix "strange"
        # situations, like moving an object to invalid
        # positions
        acc
      end
    end

    reload
  end

  private

    def create_new_item
      self.items << Item.new(name: "Insert your items!")
    end
end
