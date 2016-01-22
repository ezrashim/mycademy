class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.belongs_to :course, index: true, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :order_no

      t.timestamps null: false
    end
  end
end
