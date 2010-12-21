class Comment < ActiveRecord::Base
  # associations
  belongs_to  :memory, :touch => true # foreign key memory_id
  belongs_to  :user   # foreign key user_id

  #validation
  validates_length_of    :content,    :within => 3..180,
                                      :message => "must be between 3 and 180 characters",
                                      :allow_blank => false


end
