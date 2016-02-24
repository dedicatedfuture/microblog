class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |i|
      i.string :title
      i.text :body
      i.datetime :created, default: Time.now
    end
  end
end
