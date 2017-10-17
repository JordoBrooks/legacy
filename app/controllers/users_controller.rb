class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_for_user)
    if @user.save
      login @user
      flash[:success] = 'User created!'
      redirect_to posts_path
    else
      flash[:alert] = 'User could not be created. Please check required fields.'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def params_for_user
      params.require(:user).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation)
    end

end