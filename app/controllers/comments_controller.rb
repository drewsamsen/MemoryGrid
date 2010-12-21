class CommentsController < ApplicationController
  def create
    @comment = Comment.create!(params[:comment])
    @comment.user_id = current_user.fb_user_id
    @comment.author_name = current_user.name
    @comment.save
    flash[:notice] = "Thank you for adding to this memory"
    respond_to do |format|
      format.html { redirect_to memory_path(@comment.memory_id) }
      format.js
    end
  end


  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to memory_path(@comment.memory_id) }
      format.xml  { head :ok }
    end
  end

end