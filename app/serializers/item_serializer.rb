class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :loan_date, :return_date
  belongs_to :user
  belongs_to :contact
end
