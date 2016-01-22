class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :icon

      t.timestamps null: false
    end
  end
end
