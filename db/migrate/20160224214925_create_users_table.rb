class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :fname
      t.string :lname
      t.string :email
      t.string :description
      t.datetime :joined, default: Time.now
    end
  end
end
