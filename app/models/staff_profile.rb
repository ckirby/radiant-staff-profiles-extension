require 'digest/sha1'

class StaffProfile < ActiveRecord::Base
  belongs_to :status
  belongs_to :position_type


  # Validations
  validates_presence_of :first_name, :last_name, :login, :message => 'required'
  
  validates_presence_of :password, :password_confirmation, :message => 'required', :if => :new_record?

  validates_presence_of :position_type_id, :message => 'required', :unless => :new_record?

  validates_uniqueness_of :login, :message => 'login already in use'

  validates_confirmation_of :password, :password_confirmation, :message => 'must match confirmation', :if => :confirm_password?

  validates_length_of :login, :within => 3..40, :allow_nil => true, :too_long => '{{count}}-character limit', :too_short => '{{count}}-character minimum'
  validates_length_of :password, :within => 5..40, :allow_nil => true, :too_long => '{{count}}-character limit', :too_short => '{{count}}-character minimum', :if => :validate_length_of_password?

  attr_writer :confirm_password

  has_attached_file :photo, :styles => { :profile => '165x210' }

  #validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']

  def sha1(phrase)
    Digest::SHA1.hexdigest("--#{salt}--#{phrase}--")
  end

  def self.authenticate(login, password)
    staff_profile_user = find_by_login(login)
    staff_profile_user if staff_profile_user && staff_profile_user.authenticated?(password)
  end

  def authenticated?(password)
    self.password == sha1(password)
  end

  def after_initialize
    @confirm_password = true
  end

  def confirm_password?
    @confirm_password
  end

  def remember_me
    update_attribute(:session_token, sha1(Time.now + Radiant::Config['session_timeout'].to_i)) unless self.session_token?
  end

  def forget_me
    update_attribute(:session_token, nil)
  end

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
    "#{first_name} #{middle_initial} #{last_name}"
  end

  def lookup_name
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
  
  private

    def validate_length_of_password?
      new_record? or not password.to_s.empty?
    end

    before_create :encrypt_password, :set_position_type_id
    def encrypt_password
      self.salt = Digest::SHA1.hexdigest("--#{Time.now}--#{login}--sweet harmonious biscuits--")
      self.password = sha1(password)
    end

    def set_position_type_id
      self.position_type_id = 0 if (position_type_id == nil)
    end

    before_update :encrypt_password_unless_empty_or_unchanged
    def encrypt_password_unless_empty_or_unchanged
      user = self.class.find(self.id)
      case password
      when ''
        self.password = user.password
      when user.password
      else
        encrypt_password
      end
    end
end
