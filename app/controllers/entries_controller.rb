class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /blogs/1/entries/1
  # GET /blogs/1/entries/1.json
  def show
    @comments = Comment.where(entry_id: @entry.id)
    @comment  = @entry.comments.build
  end

  # GET /blogs/1/entries/new
  def new
    @blog  = Blog.find(params[:blog_id])
    @entry = @blog.entries.build
  end

  # GET /blogs/1/entries/1/edit
  def edit
  end

  # POST /blogs/1/entries
  # POST /blogs/1/entries.json
  def create
    @blog  = Blog.find(params[:blog_id])
    @entry = @blog.entries.build(entry_params)
    #@entry = Entry.new(entry_params)
    #@entry.blog_id = params[:id]

    respond_to do |format|
      if @entry.save
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1/entries/1
  # PATCH/PUT /blogs/1/entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1/entries/1
  # DELETE /blogs/1/entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to @blog, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @blog = Blog.find(params[:blog_id])
      @entry = Entry.find(params[:id])
      if @blog.id != @entry.blog_id
        render plain: "Not found", status: 404
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body, :blog_id)
    end
end
