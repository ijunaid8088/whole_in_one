class User < ActiveRecord::Base
  include BCrypt

  belongs_to :company
  before_save :create_hashed_password, if: :password_changed?
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: true

  validates_length_of :password, minimum: 6, if: :password_changed?

  def fullname
    "#{firstname} #{lastname}"
  end

  def created
    created_at.strftime("%d/%m/%y")
  end

  def create_hashed_password
    if password
      self.password = Password.create(password)
    end
  end
end
