module MemoriesHelper
  def add_user_link(name)   
    link_to_remote "Add friends to this memory", :html => {
                    :id => "add-friends-link" }, :url => {
                    :controller => "memories",
                    :action => "add_user_script"
                  }
    end
end
