class CreateStaffProfiles < ActiveRecord::Migration
  def self.up
    add_column "staff_profiles", "login", :string, :limit => 40, :default => "", :null => false
    add_column "staff_profiles", "password", :string, :limit => 40
  end

  def self.down
    remove_column "staff_profiles", "login"
    remove_column "staff_profiles", "password"
  end
end
