class StaffProfileAdminLoginController < ApplicationController
  no_login_required

  def login
    if request.post?
      login = params[:user][:login]
      password = params[:user][:password]
# announce_invalid_user unless self.current_user = User.authenticate(login, password)
    end
    if current_user
      if params[:remember_me]
        current_user.remember_me
        set_session_cookie
      end
      redirect_to (session[:return_to] || staff_profile_admin)
      session[:return_to] = nil
    end
  end

  private

    def announce_logged_out
      flash[:notice] = 'You are now logged out.'
    end

    def announce_invalid_user
      flash.now[:error] = 'Invalid username or password.'
    end

end