class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.text :description
      t.string :section
      t.integer :standard
      t.timestamps null: false
    end
  end
end
