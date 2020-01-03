class Item < ApplicationRecord
  belongs_to :user
  belongs_to :contact
  has_one_attached :photo

  validates :name, :loan_date, presence: true
end
