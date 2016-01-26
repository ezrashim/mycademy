class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :answer, null: false
      t.belongs_to :question, index: true, null: false
      t.belongs_to :enrollment, index: true, null: false

      t.timestamps null: false
    end
  end
end
