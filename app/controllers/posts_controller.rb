class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end
	
	def new
		@post = Post.new
	end

	def create
		@post = Post.create(params_for_post)

		redirect_to posts_path
	end

	def show
	end

	def edit
	end

	def update
		@post.update(params_for_post)
		redirect_to(post_path(@post))
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private

	def params_for_post
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

end
