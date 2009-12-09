class StaffProfileAdminLoginController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token

  def login
    if request.post?
      login = params[:username]
      password = params[:password]
      announce_string = "Login: "
      announce_string << login
      announce_string << " "
      announce_string << password
      puts announce_string
#     announce_invalid_user unless self.current_user = User.authenticate(login, password)
    else
      puts "No Login Info"
    end
    redirect_to "http://boston.com"
  end
end