class StaffProfileAdminController < ApplicationController
  
  no_login_required
  
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
end