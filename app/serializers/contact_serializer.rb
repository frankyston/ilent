class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :phone, :email
  belongs_to :user
  has_many :items
end
