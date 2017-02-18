class User < ActiveRecord::Base
  belongs_to :company
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: true

  def fullname
    "#{firstname} #{lastname}"
  end

  def created
    created_at.strftime("%d/%m/%y %I:%M %p")
  end
end
