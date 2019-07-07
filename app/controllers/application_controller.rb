class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?  # This line makes these two methods availaible to rails views. Otherwise, all methods dedined heree in the application controller are availaible to all controllers (because they inherit from this ApplicationController) but they are not available (by default) to the VIEWS. This line makes the listed methods available to the views.

  def current_user
    # @current_user = @current_user || User.find(session[:user_id]) if session[:user_id]  # the || and @current_user are usd to store the instance of the current user and avoid repeated calls to the db, except when @current user is falls. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user    # it calls the current_user method and converts its return value to true or false
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You need to be logged in to perform that action"
      redirect_to login_path
    end
  end
end
