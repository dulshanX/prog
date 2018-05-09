# тестирование контроллера активностей ActsController

require 'test_helper'

class ActsControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
  setup do
    @act = acts(:one)
    # @url_params = { locale: 'en', id: @act.id }
    @url_params = { id: @act.id }
    @user = users(:one)
  end

  test "should get index" do
    get acts_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_act_url
    assert_response :success
  end

  test "should create act" do
    sign_in @user
    assert_difference('Act.count') do
      post acts_url, params: { act: { category_id: @act.category_id, date: @act.date, desc: @act.desc, name: @act.name, value: @act.value } }
    end

    assert_redirected_to act_url(Act.last)
  end

  test "should show act" do
    get act_url(@url_params), params: { id: @act.id }
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_act_url(@url_params)
    assert_response :success
  end

  test "should update act" do
    sign_in @user
    patch act_url(@url_params), params: { act: { category_id: @act.category_id, date: @act.date, desc: @act.desc, name: @act.name, value: @act.value } }
    assert_redirected_to act_url(@act)
  end

  test "should destroy act" do
    sign_in @user
    assert_difference('Act.count', -1) do
      delete act_url(@url_params)
    end

    assert_redirected_to acts_url
  end

end
