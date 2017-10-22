module SessionsHelper

  # log in the provided user
  def login(user)
    session[:user_id] = user.id
  end

  # remember user in persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # log out the current user
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # forget user in persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # return the current user that is logged in
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  # return true if given user is the current user
  def current_user?(user)
    user == current_user
  end

  # return true if a user is currently logged in
  def logged_in?
    return !current_user.nil?
  end

  # store the URL trying to be accessed
  def store_URL
    session[:forwarding_url] = request.original_url if request.get?
  end

  # redirect to stored url or, if none, go to provided location
  def redirect_to_forwarding_url_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
