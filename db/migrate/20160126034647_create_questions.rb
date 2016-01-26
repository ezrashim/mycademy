class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :description, null: false
      t.belongs_to :lesson, index: true, null: false


      t.timestamps null: false
    end
  end
end
