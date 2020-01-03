class Contact < ApplicationRecord
  belongs_to :user
  validates :name, :phone, :email, presence: true
  validates_format_of :email, with: /@/
end
