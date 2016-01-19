class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.belongs_to :course, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.string :role, null: false, default: 'learner'

      t.timestamps null: false
    end
  end
end
