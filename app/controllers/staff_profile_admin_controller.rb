class StaffProfileAdminController < ApplicationController
  
  no_login_required
  skip_before_filter :verify_authenticity_token

  def login
    if request.post?
      login = params[:username]
      password = params[:password]
#      announce_invalid_user unless self.current_user = User.authenticate(login, password)
    else
      announce_invalid_user
      render(:action => 'login')
    end
    redirect_to "http://boston.com"
  end
  
  def show
    @profile = StaffProfile.find(params[:id])
    render(:action => 'show')
  end
  
  def edit
    @profile = StaffProfile.find(params[:id])
    render(:action => 'edit')
  end

  def update
    @profile = StaffProfile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Successfully updated the profile details."
      redirect_to(admin_profiles_path)
    else
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
      render(:action => 'edit')
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