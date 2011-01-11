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
    user_ids = []
    usr_attributes.each do |attributes|
      unless attributes[1]["uid"].to_i == 0
        new_facebooker = User.find_or_create_by_fb_user_id(attributes[1]["uid"].to_i,{:name => attributes[1]["name"].strip, :login => "facebooker_#{attributes[1]["uid"].to_i}", :password => "", :email => ""})
        new_facebooker.save(false)
       
        unless user_ids.include?(new_facebooker.id) || self.users.include?(new_facebooker)
         user_ids << new_facebooker.id
         tag = Tag.create(:user => new_facebooker,:memory => self)
         unless new_facebooker.email.blank?
           NotifyMailer.deliver_added_to_mem_notify(new_facebooker,self,attributes[1]["current_user"].name)
         end 
        end
      end
    end 
  end


  def user_is_owner?(user)
    (@tag = Tag.find_by_user_id_and_memory_id(user.id, self.id)) && @tag.owner
  end
  
  def author_id(memory)
    @users = memory.users.find(:all)
      users.each do |user|
        if user_is_owner?(user)
          @user = user
        end
    end
    @user.fb_user_id
  end
  

  
end
