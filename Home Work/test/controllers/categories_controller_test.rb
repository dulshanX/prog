# тестирование контроллера категорий CategoriesController

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
  setup do
    @category = categories(:one)
    @url_params = { id: @category.id }
    @user = users(:one)
    @admin = users(:admin)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in @admin
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in @admin

    assert_difference('Category.count') do
      post categories_url, params: { category: { desc: @category.desc, name: @category.name } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@url_params)
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get edit_category_url(@url_params)
    assert_response :success
  end

  test "should update category" do
    sign_in @admin
    patch category_url(@url_params), params: { category: { desc: @category.desc, name: @category.name } }
    assert_redirected_to category_url(@category)
  end

  test "should destroy category" do
    sign_in @admin
    assert_difference('Category.count', -1) do
      delete category_url(@url_params)
    end

    assert_redirected_to categories_url
  end

end
