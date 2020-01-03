class Item < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  validates :name, :loan_date, presence: true
end
