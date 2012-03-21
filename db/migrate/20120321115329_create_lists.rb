class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name

      t.timestamps
    end

    create_table :lists_users do |t|
      t.integer :user_id
      t.integer :list_id
    end
  end
end
