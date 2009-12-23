class AddMiddleInitialToStaffProfiles< ActiveRecord::Migration
  def self.up
    add_column "staff_profiles", "middle_initial", :string, :limit => 5
  end

  def self.down
    remove_column "staff_profiles", "middle_initial"
  end
end
