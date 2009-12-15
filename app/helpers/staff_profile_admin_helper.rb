module StaffProfileAdmin::StaffProfileAdminHelper
  def form_for_staff_profile_admin(profile, html_options = {}, &block)
    url = staff_profile_admin_url(profile)
    html_options[:multipart] = true
    html_options[:method] = :put 
    form_for(:profile, @profile, :url => url, :html => html_options, &block)
  end
end
