class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.belongs_to :course, index: true, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :lesson_no, null: false, unique: true

      t.timestamps null: false
    end
  end
end
