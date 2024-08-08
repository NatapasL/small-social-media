# frozen_string_literal: true

class PostsController < AuthenticatedApplicationController
  def index
    posts = Post.all
    render json: { posts: }
  end

  def create
    post = Post.new(post_params)
    post.created_by = current_user
    post.save!

    render json: { post: }, status: :ok
  end

  def show
    post = Post.find(params[:id])

    render json: { post: }, status: :ok
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)

    render json: { post: }, status: :ok
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!

    render json: {}, status: :ok
  end

  private

  def post_params
    params.fetch(:post).permit(:text)
  end
end
