class Company < ActiveRecord::Base
  belongs_to :admin
  has_many :users
  validates :namespace, presence: true, uniqueness: true
  validates :company_name, presence: true
  validates_format_of :namespace, :with => /\A(?:http(?:s)?:\/\/)?(?:www\.)?(?:[\w-]*)\.\w{2,}\z/

  def created
    created_at.strftime("%d/%m/%y %I:%M %p")
  end
end
