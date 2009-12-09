class StaffProfileAdminLoginController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token

  def login
    redirect_to "http://boston.com"
#    if request.post?
#      login = params[:username]
#      password = params[:password]
#     announce_invalid_user unless self.current_user = User.authenticate(login, password)
#    end
#    if current_user
#      if params[:remember_me]
#        current_user.remember_me
#        set_session_cookie
#      end
#      redirect_to (session[:return_to] || staff_profile_admin_url)
#      session[:return_to] = nil
#    end
  end
end