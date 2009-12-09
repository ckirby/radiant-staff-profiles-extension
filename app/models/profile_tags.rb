module ProfileTags
  include Radiant::Taggable

  class TagError < StandardError; end

  desc %{
    Generates a login form for staff members to get to their stafff profile admin page
 
    Usage:
    <pre><code> <r:profile_login/></code></pre>
  }
  tag 'profile_login' do |tag|
    results = []
    action =  "/staff_profile_admin/login"
    results << %(<form action="#{action}" method="post">)
    results << %(<table><tr><td>Username:</td><td><input type="text" name="username"></td></tr>)
    results << %(<tr><td>Password:</td><td><input type="password" name="password"></td></tr>)
    results << %(</table><input type="submit" value="Login" />)
    results << %(</form>)
  end

  desc %{
     Causes the tags referring to a profile's attributes to refer to the current profile.
     Fetches a profile requested by 'name' in the tag
     *Usage:*
     <pre><code><r:profile [name="Scott Summers"]>...</r:profile></code></pre>
   }
   tag 'profile' do |tag|
     if tag.attr['name']
       name = tag.attr['name'].split(' ')
       last_name = name.pop
       first_name = name.join(' ')
       tag.locals.profile = StaffProfile.find_by_first_name_and_last_name(first_name, last_name)
     end
  
     raise "<script language='javascript'> location.href='/people';</script>" unless tag.locals.profile
     tag.expand
   end
 
   desc %{
     Fetches a profile requested with the url parameter 'id' which is the uuid of the row. If the user has an alternate website defined in their profile, they will get redirected to that page.
 
     *Usage:*
     <pre><code><r:get_profile>...</r:get_profile></code></pre>
   }
   tag 'get_profile' do |tag| 
       if (request.parameters[:id])
         id = request.parameters[:id]
         tag.locals.profile = StaffProfile.find_by_uuid(id)
       end
     raise "<script language='javascript'> location.href='/people';</script>" unless tag.locals.profile
     tag.expand
   end
  

  desc %{
    Gives access to the available profiles.
  
    *Usage:*
    <pre><code><r:profiles>...</r:profiles></code></pre>
  }
  tag 'profiles' do |tag|
    tag.locals.profiles = StaffProfile.find(:all, :order => 'last_name, first_name')
    tag.expand
  end

  desc %{
    Cycles through each of the staff profiles. Inside this tag all attribute tags
    are mapped to the current profile. By default only published profiles are included.

    *Usage:* 
    <pre><code><r:profiles:each [status="Published"] [position="Position Name,Position Name 2"] [photo_required="true"] >...</r:profiles:each></code></pre>
  }
  tag 'profiles:each' do |tag|
    profiles = tag.locals.profiles

    tag.attr['status'] ||= 'Published' # default
    if tag.attr['status'] && (tag.attr['status'].downcase != 'all')
      profiles = profiles.select { |profile| profile.status.name == tag.attr['status'] }
    end
    
    if tag.attr['position']
      position_names = tag.attr['position'].split(',')
      profiles_with_position = []
      position_names.each do |position|
        profiles_with_position.concat(profiles.select { |profile| profile.position_name == position })  
      end
      profiles = profiles_with_position    
    end
    
    if tag.attr['photo_required'] == 'true'
      profiles = profiles.select { |profile| profile.photo.url(:profile) != '/photos/profile/missing.png' }
    end

    results = []
    profiles.each do |profile|
      tag.locals.profile = profile
      results << tag.expand
    end
    results
  end

  { :name => :full_name, :job_title => :title, :email => :email, :biography => :filtered_biography, :address => :address, :degree => :degree, :affiliations => :affiliations, :clinical_interests => :clinical_interests, :website => :website, :phone => :phone, :fax => :fax, :publications => :publications, :position => :position_name, :research => :research, :id => :uuid  }.each do |name, attr|
  desc %{
    Returns the #{name.to_s} of the staff member.
    *Usage:*
    <pre><code><r:profile:#{name.to_s}/></code></pre>
  }
    tag "profile:#{name}" do |tag|
      profile = tag.locals.profile
      double_text = ''
      if (profile.send(attr) != '' && tag.double?)
        double_text = tag.expand
        tag.attr['show_text'] ||= 'before'
        showwhere = tag.attr['show_text']
        if (showwhere == 'after')
          profile.send(attr) << double_text
        elsif (showwhere == 'only')
          double_text
        else
          double_text << profile.send(attr)
        end
      else
        profile.send(attr)
      end
    end
  end


  desc %{
    Returns the profile image URL for a staff member.

    *Usage:*
    <pre><code><r:profile:image_url/></code></pre>
  }
  tag 'profile:image_url' do |tag|
    profile = tag.locals.profile
    profile.photo.url(:profile)
  end
end
