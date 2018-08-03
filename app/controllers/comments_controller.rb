class CommentsController < ApplicationController
  before_action :set_comment, only: [:approve, :destroy]

  # GET /blogs/1/entries/1/comments/new
  def new
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build
    @comment.status = 'unapproved'
  end

  # POST /blogs/1/entries/1/comments
  # POST /blogs/1/entries/1/comments.json
  def create
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(comment_params)
    @comment.status = 'unapproved'

    respond_to do |format|
      if @comment.save
        NoticeMailer.notify_admin_comment_added(@blog, @entry, @comment).deliver
        format.html { redirect_to blog_entry_path(@blog, @entry), notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /blogs/1/entries/1/comments/1
  # DELETE /blogs/1/entries/1/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_entry_path(@blog, @entry), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH /blogs/1/entries/1/comments/1/approve
  def approve
    @comment.status = 'approved'
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_entry_path(@blog, @entry), notice: 'Comment was successfully approved.' }
        format.json { head :no_content }
      else
        format.html { redirect_to blog_entry_path(@blog, @entry), notice: 'Comment was unsuccessfully approved.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @entry = Entry.find(params[:entry_id])
      @blog = Blog.find(params[:blog_id])
      if @blog.id != @entry.blog_id or @entry.id != @comment.entry_id
        render plain: "Not found", status: 404
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :status, :entry_id)
    end
end
