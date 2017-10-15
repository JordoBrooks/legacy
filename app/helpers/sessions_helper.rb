module SessionsHelper

  # log in the provided user
  def login(user)
    session[:user_id] = user.id
  end

  # log out the current user
  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  # return the current user that is logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true if a user is currently logged in
  def logged_in?
    return !current_user.nil?
  end

end
