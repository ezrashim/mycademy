class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description
      t.string :icon
      t.string :role, null: false, default: 'learner'

      t.timestamps null: false
    end
  end
end
