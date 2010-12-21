class Tag < ActiveRecord::Base
  belongs_to :memory # foreign key - memory_id
  belongs_to :user # foreign key - user_id
end
