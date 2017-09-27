class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end
	
	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params_for_post)
		if @post.save
			flash[:success] = 'Post created!'
			redirect_to posts_path
		else
			flash.now[:alert] = 'Post could not be created. Missing necessary information.'
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(params_for_post)
			flash[:success] = 'Post updated!'
			redirect_to(post_path(@post))
		else
			flash[:alert] = 'Post could not be updated. Missing necessary information.'
			render :edit
		end
	end

	def destroy
		if @post.destroy
			flash[:success] = 'Post deleted!'
			redirect_to posts_path
		end
	end

	private

	def params_for_post
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

end
