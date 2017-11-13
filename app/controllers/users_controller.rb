class UsersController < ApplicationController
  before_action :logged_in_user?, only: [:edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_for_user)
    if @user.save
      login @user
      flash[:success] = 'User created!'
      redirect_to_forwarding_url_or posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.update_attribute(:image, params[:user][:image])
    @user.update_attribute(:bio, params[:user][:bio])
      flash[:success] = 'Profile updated!'
      redirect_to user_path(@user)
  end

  def show
    @posts = @user.posts.order('created_at DESC').page params[:page]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User removed.'
    redirect_to login_path
  end

  private

    # strong params for mass assignment vulnerability prevention
    def params_for_user
      params.require(:user).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation, :bio)
    end

    def correct_user?
      @user = User.find(params[:id])
      redirect_to root_url if !current_user?(@user)
    end

    def set_user
      @user = User.find(params[:id])
    end

end