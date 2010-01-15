class AddChangePasswordFlagToStaffProfiles< ActiveRecord::Migration
  def self.up
    add_column "staff_profiles", "change_password", :boolean, :default => true
  end

  def self.down
    remove_column "staff_profiles", "change_password"
  end
end
