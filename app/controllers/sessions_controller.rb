class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      login @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to user_path(@user)
    else
      @user = User.new
      flash.now[:alert] = 'Invalid email/password combination!'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to login_path
  end
end
