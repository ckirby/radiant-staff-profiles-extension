class StaffProfileAdminController < ApplicationController
  
  no_login_required
  skip_before_filter :verify_authenticity_token

  def login
    if request.post?
      login = params[:staffuser][:login]
      password = params[:staffuser][:password]
      announce_invalid_user unless current_staff_user = StaffProfile.authenticate(login, password)
    else
      render(:action => 'login')
    end
    if current_staff_user
      redirect_to staff_profile_admin_url(current_staff_user.id)
    end
  end
  
  def show
    id = params[:id]
    if id != current_staff_user.id
      render(:action => 'login')
    else
      @profile = StaffProfile.find(params[:id])
      render(:action => 'show')
    end
  end
  
  def edit
    @profile = StaffProfile.find(params[:id])
    render(:action => 'edit')
  end

  def update
    @profile = StaffProfile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Successfully updated the profile details."
      render(:action => 'show')
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