class PostsController < ApplicationController

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
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(params_for_post)
		redirect_to(post_path(@post))
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def params_for_post
		params.require(:post).permit(:image, :caption)
	end

end
