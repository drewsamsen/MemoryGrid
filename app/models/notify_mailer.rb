class NotifyMailer < ActionMailer::Base
  def added_to_mem_notify(user,memory,name)
    recipients    user.email
    from          "notification@thememorygrid.com"
    subject       "#{name} added you to a memory"
    body          "You have indeed been added to a memory! -- #{memory.body}"
  end

end
