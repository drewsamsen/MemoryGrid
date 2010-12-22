class MemoriesController < ApplicationController
  # GET /memories
  # GET /memories.xml
  layout "index"
  before_filter :login_required
  before_filter :check_permission,:only => [:show,:edit,:update]
  before_filter :set_params,:only => :update

  auto_complete_for :memory, :title


  def index
    @memories = current_user.memories.find(:all, :order => 'updated_at desc')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memories }
    end
  end

  def fb_invite
    @memory = Memory.find(params[:id])

    @tag_users = @memory.users.find(:all,:conditions=> ["last_logged_in IS NULL"])

    @exclude_users = Array.new
    @friends = friends
    @friends.each do |f|
      unless @tag_users.map{|t| t.fb_user_id}.include? f.uid
        @exclude_users << f.uid
      end
    end
    @exclude_users = @exclude_users.join(',').to_s

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /memories/1
  # GET /memories/1.xml
  def show

      respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @memory }
    end
  end

  # GET /memories/new
  # GET /memories/new.xml
  def new
    @memory = Memory.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @memory }
    end
  end

  def set_friends
    @memory = Memory.new
    @friends = friends

    render :json => @friends
  end

  def set_friends_edit
    @memory = Memory.find(params[:memory_id])
    @friends = friends
    @friends_names = Array.new
    @friends.each do |f|
      @friends_names << f.name
    end
    render :partial => 'memories/set_friends'
  end

  # GET /memories/1/edit
  def edit

  end

  # POST /memories
  # POST /memories.xml
  def create

   @memory = Memory.new(params[:memory])

    respond_to do |format|
      if @memory.save
        @tag = Tag.create(:user => current_user,:memory => @memory,:owner => true)
        format.html { redirect_to(@memory, :notice => 'Memory was successfully created.') }
        format.xml  { render :xml => @memory, :status => :created, :location => @memory }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @memory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /memories/1
  # PUT /memories/1.xml
  def update

    respond_to do |format|
      if @memory.update_attributes(params[:memory])
        format.html { redirect_to(@memory, :notice => 'Memory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @memory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /memories/1
  # DELETE /memories/1.xml
  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy

    respond_to do |format|
      format.html { redirect_to(memories_url) }
      format.xml  { head :ok }
    end
  end

  def remove_tagged_users
    @memory = Memory.find(params[:id])
    @tag = Tag.find_by_user_id_and_memory_id(params[:user_id], @memory.id)
    @tag.destroy
    render :partial => 'memories/remove_tagged_users'
  end

private

 def check_permission
   @memory = Memory.find(params[:id])
   unless @memory.users.include?(current_user)
     redirect_to :controller => 'memories',:action => 'index'
   end
 end

 def set_params
   unless params[:memory][:usr_attributes].blank?
     @friends = friends
    params[:memory][:usr_attributes].each do |a|
      @friends.each do |fr|
        a[1]["uid"] = fr.uid.to_i if fr.name == a[1]["name"]
      end
    end

    end
 end

end

