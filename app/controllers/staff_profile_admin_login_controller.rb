class StaffProfileAdminLoginController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token

  def login
    if request.post?
      login = params[:username]
      password = params[:password]
      puts "Login: #{$login} #{$password}"
#     announce_invalid_user unless self.current_user = User.authenticate(login, password)
    else
      puts "No Login Info"
    end
    redirect_to "http://boston.com"
  end
end