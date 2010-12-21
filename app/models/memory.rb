class Memory < ActiveRecord::Base

  # associations
  has_many :comments, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  has_many :users, :through => :tags

  #validation
  validates_length_of       :body,    :within => 5..180,
                                      :message => "must be between 5 and 180 characters",
                                      :allow_blank => false
  
  def usr_attributes=(usr_attributes)
    usr_attributes.each do |attributes|
      new_facebooker = User.find_or_create_by_fb_user_id(attributes[1]["uid"].to_i,{:name => attributes[1]["name"].strip, :login => "facebooker_#{attributes[1]["uid"].to_i}", :password => "", :email => ""})
      new_facebooker.save(false)
      tag = Tag.create(:user => new_facebooker,:memory => self)
    end 
  end
  
  def user_is_owner?(user)
    (@tag = Tag.find_by_user_id_and_memory_id(user.id, self.id)) && @tag.owner
  end

  
end
