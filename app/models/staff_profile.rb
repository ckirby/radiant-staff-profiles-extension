class StaffProfile < ActiveRecord::Base
  belongs_to :status
  belongs_to :position_type

  has_attached_file :photo, :styles => { :profile => '110x140' }

  #validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']
  validates_presence_of :first_name, :last_name

  def status
    Status.find(self.status_id)
  end

  def status=(value)
    self.status_id = value.id
  end

  def position
    PositionType.find(self.position_type_id)
  end

  def position=(value)
    self.position_type_id = value.id
  end


  def full_name
    "#{first_name} #{last_name}"
  end

  def filtered_biography
    if defined? TextileFilter
      TextileFilter.filter(self.biography)
    else
      self.biography
    end
  end
  
  def position_name
    position.name
  end
end
