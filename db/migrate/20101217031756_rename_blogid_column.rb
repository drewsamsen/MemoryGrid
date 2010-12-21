class RenameBlogidColumn < ActiveRecord::Migration
  def self.up
    rename_column :tags, :blog_id, :memory_id
  end

  def self.down
    rename_column :tags, :memory_id, :blog_id
  end
end