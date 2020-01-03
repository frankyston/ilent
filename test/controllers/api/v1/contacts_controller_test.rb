require 'test_helper'

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @contact = contacts(:one)
    @user = @contact.user
    @token = get_token_for_user(@user)
  end

  test "should show contacts" do
    get api_v1_contacts_url, headers: {
      Authorization: @token
    }

    assert_response :success
  end

  test 'should show contact' do
    get api_v1_contact_url(@contact), headers: {
      Authorization: @token
    }, as: :json

    assert_response :success
  end

  test 'should create contact' do
    post api_v1_contacts_url, params: {
      contact: {
        name: Faker::Name.first_name,
        phone: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email
      }
    }, headers: {
      Authorization: @token
    }, as: :json

    assert_response :created
  end

  test 'should not create contact' do
    post api_v1_contacts_url, params: {
      contact: {
        name: Faker::Name.first_name,
        phone: Faker::PhoneNumber.cell_phone,
      }
    }, headers: {
      Authorization: @token
    }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should update contact' do
    patch api_v1_contact_url(@contact), params: {
      contact: {
        name: Faker::Name.first_name,
      }
    }, headers: {
      Authorization: @token
    }, as: :json

    assert_response :success
  end

  test 'should not update contact with email' do
    patch api_v1_contact_url(@contact), params: {
      contact: {
        email: 'bad_email',
      }
    }, headers: {
      Authorization: @token
    }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should not update contact' do
    patch api_v1_contact_url(@contact), params: {
      contact: {
        name: Faker::Name.first_name,
      }
    }, as: :json

    assert_response :unauthorized
  end

  test 'should destroy contact' do
    delete api_v1_contact_url(@contact), 
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :no_content
  end
end
