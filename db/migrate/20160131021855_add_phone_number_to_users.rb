class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area_code, :integer
    add_column :users, :first_digits, :integer
    add_column :users, :last_digits, :integer
  end
end
