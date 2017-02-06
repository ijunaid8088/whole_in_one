class Admin < ActiveRecord::Base
    include BCrypt

  before_save :create_hashed_password, if: :password_changed?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_one :company

  validates_length_of :password, minimum: 6, if: :password_changed?

  def create_hashed_password
    if password
      self.password = Password.create(password)
    end
  end
end
