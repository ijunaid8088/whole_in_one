class Company < ActiveRecord::Base
  belongs_to :admin
  validates :namespace, presence: true, uniqueness: true
  validates :company_name, presence: true
  validates_format_of :namespace, :with => /\A(?:http(?:s)?:\/\/)?(?:www\.)?(?:[\w-]*)\.\w{2,}\z/
end
