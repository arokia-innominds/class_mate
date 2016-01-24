class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :student, index: true
      t.references :assignment, index: true
      t.text :description
      t.timestamps null: false
    end
  end
end
