class PostsController < ApplicationController
	before_action :logged_in_user?
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
	before_action :owns_post?, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all.order('created_at DESC').page params[:page]
	end
	
	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(params_for_post)
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

	def like
		if @post.liked_by current_user
			respond_to do |format|
				format.html { redirect_back }
				format.js
			end
		end
	end

	private

	def params_for_post
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owns_post?
		unless current_user?(@post.user)
			redirect_to root_path
		end
	end

end
