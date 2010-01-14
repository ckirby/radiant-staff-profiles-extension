class Admin::ProfilesController < ApplicationController
  only_allow_access_to :new, :create, :edit, :update, :destroy,
    :when => :admin,
    :denied_url => { :controller => 'profiles', :action => 'index' },
    :denied_message => 'You must have administrative privileges to perform this action.'
  

  def index
    @profiles = StaffProfile.find(:all, :order => "last_name, first_name")
    render(:action => 'index')
  end

  def new
    @profile = StaffProfile.new
    render(:action => 'edit')
  end

  def create
    @profile = StaffProfile.new(params[:profile])
    if @profile.save
      flash[:notice] = "Successfully added a new profile."
      redirect_to(admin_profiles_path)
    else
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
      render(:action => 'edit')
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
      redirect_to(admin_profiles_path)
    else
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
      render(:action => 'edit')
    end
  end

  def destroy
    @profile = StaffProfile.find(params[:id])
    @profile.destroy
    flash[:error] = "The profile was deleted."
    redirect_to(admin_profiles_path)
  end
end
