class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :blog_id
      t.integer :user_id
      t.boolean :owner,:default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
