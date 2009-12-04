class AddSaltToStaffProfiles < ActiveRecord::Migration
  def self.up
    add_column :staff_profiles, :salt, :string
    StaffProfiles.reset_column_information
    StaffProfiles.update_all :salt => "sweet harmonious biscuits"
  end

  def self.down
    remove_column :staff_profiles, :salt
  end
end
