class AddSaltToStaffProfiles < ActiveRecord::Migration
  def self.up
    add_column :staff_profiles, :salt, :string, :default=> "sweet harmonious biscuits"
  end

  def self.down
    remove_column :staff_profiles, :salt
  end
end
