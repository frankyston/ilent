require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
    @contact = contacts(:one)
  end

  test 'should create item' do
    item = Item.new name: 'Boll', loan_date: Date.current, user_id: @contact.user_id, contact_id: @contact.id

    assert item.valid?
  end


  test 'should not create item without name' do
    item = Item.new loan_date: Date.current, user_id: @contact.user_id, contact_id: @contact.id

    assert_not item.valid?
  end

  test 'should not create item without loan_date' do
    item = Item.new name: 'Boll', user_id: @contact.user_id, contact_id: @contact.id

    assert_not item.valid?
  end
end
