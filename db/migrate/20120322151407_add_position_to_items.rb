class AddPositionToItems < ActiveRecord::Migration
  def change
    add_column :items, :position, :integer

  end
end
