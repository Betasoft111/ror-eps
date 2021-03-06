class User < ActiveRecord::Base
  #attr_accessible :email, :password, :password_confirmation
  has_many :company_staffs, :foreign_key => :company_id
  belongs_to :subscription_plan, :foreign_key => :plan_id
  
  belongs_to :company_requests, :foreign_key => :request_by
  belongs_to :company_requests, :foreign_key => :request_to

  attr_accessor :password
  before_save :encrypt_password
  before_update :encrypt_password
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :user_type
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
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