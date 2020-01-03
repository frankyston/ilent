require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'contact be valid' do
    contact = Contact.new(name: 'Carolyn', phone: '85991929393', email: 'carolyn@bol.com.br', user_id: @user.id)
    assert contact.valid?
  end

  test 'contact be invalid' do
    contact = Contact.new(name: 'Carolyn', user_id: @user.id)
    assert_not contact.valid?
  end
end