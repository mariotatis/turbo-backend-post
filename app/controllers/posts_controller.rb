class PostsController < ApplicationController

  include AuthenticationHelper

  before_action :set_post, except: [:fetch_page, :index, :new, :create]

  # GET /posts or /posts.json
  def index
    @posts = current_user.posts.order(created_at: :desc)
    @posts = @posts.where(liked: true) if params[:liked] == true
    @posts = @posts.where(bookmarked: true) if params[:bookmarked] == true

    #@posts = @posts.paginate(page: params[:page], per_page: 10)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  def fetch_page
    @post = current_user.posts.find(params[:post_id])
    if @post.post_url.present?
      @page = MetaInspector.new(@post.post_url)
    else
      @page = nil
    end
  
    respond_to do |format|
      format.js
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { refresh_or_redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json

  def update
    @post = current_user.posts.find(params[:id]) # Ensure the post belongs to the current user
  
    respond_to do |format|
      if @post.update(post_params)
        format.html { refresh_or_redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = current_user.posts.find(params[:id]) # Ensure the post belongs to the current user
    @post.destroy
  
    respond_to do |format|
      format.html { recede_or_redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_like
    @post.update(liked: !@post.liked)
    render json: { liked: @post.liked }
  end

  def toggle_bookmark
    @post.update(bookmarked: !@post.bookmarked)
    render json: { bookmarked: @post.bookmarked }
  end

  def turbo_native_redirect(path)
    redirect_to(path, status: :see_other)
    Turbo::Native::Session.new(response).visit(path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :image_url, :tags, :post_url)
    end
end
