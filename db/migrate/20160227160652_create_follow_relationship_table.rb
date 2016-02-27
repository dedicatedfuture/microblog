class CreateFollowRelationshipTable < ActiveRecord::Migration
  def change
    create_table :followers do |i|
      i.integer :followed
      i.integer :following
    end
  end
end
