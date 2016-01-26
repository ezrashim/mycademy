class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :lesson, index: true, null: false
      t.string :question, null: false
    end
  end
end
