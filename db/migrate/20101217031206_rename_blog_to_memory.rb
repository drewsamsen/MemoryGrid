class RenameBlogToMemory < ActiveRecord::Migration
  def self.up
    rename_table :blogs, :memories
  end

  def self.down
    rename_table :memories, :blogs
  end
end