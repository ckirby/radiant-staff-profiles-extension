class CreateStaffProfiles < ActiveRecord::Migration
  def self.up
    create_table :staff_profiles do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :degree
      t.string   :title
      t.integer  :position_type_id,  :default => 0, :null => false
      t.string   :email
      t.string   :phone
      t.string   :fax
      t.string   :website
      t.text     :address
      t.integer  :status_id,  :default => 1, :null => false
      t.string   :filter_id
      t.text     :biography
      t.text     :affiliations
      t.text     :research
      t.text     :clinical_interests
      t.text     :publications
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :staff_profiles
  end
end
