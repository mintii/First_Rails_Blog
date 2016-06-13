class PostsController < ApplicationController
  # before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:admin, :new, :create, :edit, :update, :destroy ]

  def index
    if params[:category].blank?
      @posts = Post.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def show
    # As we already have our “before_action” filter set on the “show” action,
    # it does the job for us to find into the Post model database the one with
    # the “:id” provided in the URL params
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "The post was created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Update successful"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "Post destroyed"
  end

  def admin
    redirect_to root_path if authenticate
  end

protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "test" && password == "test"
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end

  # def find_post
  #   @post = Post.find(params[:id])
  # end

end
