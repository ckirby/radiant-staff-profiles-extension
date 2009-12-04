# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class StaffProfilesExtension < Radiant::Extension
  version "0.2"
  description "Adds the abilitiy to create and display staff and member profile information"
  url "http://github.com/zapnap/radiant-staff-profiles-extension"
  
  define_routes do |map|
    map.namespace 'admin' do |admin|
      admin.resources :profiles   
    end
    map.resources :staff_profile_admin, :only => [:edit, :show, :update]
    map.staff_profile_admin_login '/staff_profile_admin', :controller => 'staff_profile_admin_login', :action => 'login'
  end
  
  def activate
    admin.tabs.add "Profiles", "/admin/profiles", :visibility => [:all]
    Page.send :include, ProfileTags
  end
  
  def deactivate
    admin.tabs.remove "Profiles"
  end
end
