module SessionsHelper  
  # checks if user is logged in
  def logged_in?
    session[:admin] ? true : false
  end
  
  # returns currently logged admin
  def current_user
    session[:admin]
  end
end
