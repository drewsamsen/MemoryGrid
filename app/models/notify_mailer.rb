class NotifyMailer < ActionMailer::Base
  def added_to_mem_notify(user, memory)
    recipients    user.email
    from          "The Memory Grid"
    subject       "#{user.name} added you to a memory"
    body          "You have indeed been added to a memory! -- #{memory.body}"
  end

end
