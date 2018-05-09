# интеграционное тестирование взаимодействия разных компонент

require 'test_helper'

class FlowsTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
  setup do
    @act = acts(:one)
    @category = categories(:one)
    @user = users(:one)
    @admin = users(:admin)
  end

  test "attempt to create action" do
    # без авторизации
    get new_act_url
    assert_redirected_to new_user_session_url # перенаправление на авторизацию

    # с авторизацией
    sign_in @user
    get new_act_url
    assert_response :success # успешный переход по ссылке создания новой активности

    post acts_url, params: { act: { category_id: @act.category_id, date: @act.date, desc: @act.desc, name: @act.name, value: @act.value } }
    assert_redirected_to act_url(Act.last) # перенаправление на просмотр созданной активности

    follow_redirect!
    assert_equal act_path(Act.last), path # переход на просмотр созданной активности успешно завершен

    # проверка элементов загруженной страницы
    assert_select '.panel-heading strong', Act.last.name # панель bootstrap с заголовком = названию созданной активности
  end

  test "attempt to create category" do
    # без авторизации
    get new_category_url
    assert_redirected_to root_url # перенаправление на главную страницу

    # с авторизацией обычным пользователем
    sign_in @user
    get new_category_url
    assert_redirected_to root_url
    sign_out @user

    # с авторизацией админом
    sign_in @admin
    get new_category_url
    assert_response :success # успешный переход по ссылке создания новой категории

    post categories_url, params: { category: { desc: @category.desc, name: @category.name } }
    assert_redirected_to category_url(Category.last) # перенаправление на просмотр созданной категории

    follow_redirect!
    assert_equal category_path(Category.last), path # переход успешно завершен

    # проверка элементов загруженной страницы
    assert_select '.panel-heading strong', Category.last.name # панель bootstrap с заголовком = названию созданной категории
  end

end
