# системные тесты: страница категорий

require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
include Devise::Test::IntegrationHelpers
  setup do
    @category = categories(:one)
    @user = users(:one)
    @admin = users(:admin)
  end

  # попытка с главной страницы через кнопку добавить новую категорию
  test "index page" do
    # вход без авторизации: кнопки добавления категории не должно быть
    visit categories_url
    assert_selector ".btn", text: "Новая Категория", count: 0 # проверка наличия кнопки доб категории

    # после авторизации обычным пользователем: кнопка добавления не должна появляться
    sign_in @user
    visit categories_url
    assert_selector ".btn", text: "Новая Категория", count: 0
    sign_out @user

    # после авторизации администратором: кнопка добавления должна появиться
    sign_in @admin
    visit categories_url
    assert_selector ".btn", text: "Новая Категория"

    # нажатие на кнопку доб активности
    click_on "Новая Категория"

    # заполнение формы создания новой категории
    fill_in "category[name]", with: "Саморазвитие"
    fill_in "category[desc]", with: "умственное или физическое развитие человека путём самостоятельных занятий, упражнений"

    # отправка формы и проверка появления новой записи
    assert_difference('Category.count') do
      click_on "Сохранить"
    end

    new_category = Category.last
    assert_equal "Саморазвитие", new_category.name
    assert_equal "умственное или физическое развитие человека путём самостоятельных занятий, упражнений", new_category.desc

  end

end
