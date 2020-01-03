require 'test_helper'

class Api::V1::ItemsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper
  
  setup do
    @item = items(:one)
    @user = @item.user
    @token = get_token_for_user(@user)
  end

  test 'should show items' do
    get api_v1_items_url,
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :success
  end

  test 'should show item' do
    get api_v1_item_url(@item), 
    headers: { 
      Authorization: @token 
    }, as: :json

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @item.name, json_response['name']
  end

  test 'should create item' do
    post api_v1_items_url, params: {
      item: {
        name: 'Ball',
        loan_date: Date.current,
        contact_id: @user.contacts.first.id
      }
    },
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :created
  end

  test 'should not create item' do
    post api_v1_items_url, params: {
      item: {
        name: 'Ball'
      }
    },
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should update item' do
    @params = {
      item: {
        name: 'Ball'
      }
    }
    patch api_v1_item_url(@item), params: @params,
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)

    assert_equal @params[:item][:name], json_response['name']
  end

  test 'should not update item' do
    patch api_v1_item_url(@item), params: {
      item: {
        name: ''
      }
    },
    headers: {
      Authorization: @token
    }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should destroy item' do
    delete api_v1_item_url(@item), headers: {
      Authorization: @token
    }, as: :json
  end
end
