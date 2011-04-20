class ChangeIntToBigInt < ActiveRecord::Migration
  def self.up
    change_column :comments, :user_id, 'bigint'
  end

  def self.down
   change_column :comments, :user_id, :integer
  end
end



