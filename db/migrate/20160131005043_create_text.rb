class CreateText < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :text
      t.belongs_to :enrollment, index: true, null: false

      t.timestamps null: false
    end
  end
end
