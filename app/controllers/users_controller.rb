class UsersController < ApplicationController
  before_action :logged_in_user?, only: [:edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params_for_user)
      flash[:success] = 'Profile updated!'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User removed.'
    redirect_to login_path
  end

  private

    # strong params for mass assignment vulnerability prevention
    def params_for_user
      params.require(:user).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation)
    end

    def correct_user?
      @user = User.find(params[:id])
      redirect_to root_url if !current_user?(@user)
    end

end