class NotifyMailer < ActionMailer::Base
  def added_to_mem_notify(user,memory,name)
    recipients    user.email
    from          "notification@thememorygrid.com"
    subject       "#{name.name} added you to a memory"
    body          :user => user, 
                  :memory => memory, 
                  :name => name
  end

  def comment_notify(current_user,comment,tagged_user)
    recipients    tagged_user.email
    from          "notification@thememorygrid.com"
    subject       "#{current_user.name} commented on you memory"
    body          :current_user => current_user, 
                  :comment => comment, 
                  :tagged_user => tagged_user
  end
end