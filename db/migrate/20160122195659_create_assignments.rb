class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.timestamps null: false
      t.references :class_room, index: true
    end
  end
end
