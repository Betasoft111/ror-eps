class Admin::AdminUser < ActiveRecord::Base
	#attr_accessor :password
  	before_save :encrypt_password

	validates_presence_of :first_name
    validates_presence_of :last_name
    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email
    validates_uniqueness_of :email

  def self.authenticate(email, password)
    admin = find_by_email(email)
    if admin && admin.password_hash == BCrypt::Engine.hash_secret(password, admin.password_salt)
      admin
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
