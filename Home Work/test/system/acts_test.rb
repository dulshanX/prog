# системные тесты:
# 1. проверка создания активности через интерфейс пользователя
# 2. проверка функционирования переключения локали (код javascript)
require "application_system_test_case"

class ActsTest < ApplicationSystemTestCase
include Devise::Test::IntegrationHelpers
  setup do
    @category = categories(:one)
    @user = users(:one)
  end

  # попытка с главной страницы через кнопку добавить новую активность
  test "index page" do
    # вход без авторизации: кнопки добавления активности не должно быть
    visit acts_url
    assert_selector ".btn", text: "Новая Активность", count: 0 # проверка наличия кнопки доб активности

    # после авторизации: кнопка добавления активности должна появиться
    sign_in @user
    visit acts_url
    assert_selector ".btn", text: "Новая Активность"

    # нажатие на кнопку доб активности
    click_on "Новая Активность"

    # заполнение формы создания новой активности
    fill_in "act[value]", with: "9"
    fill_in "act[name]", with: "Программирование на Ruby"
    fill_in "act[desc]", with: "Подготовка к экзамену по программированию"
    select @category.name, from: "act[category_id]"

    # отправка формы и проверка появления новой записи
    assert_difference('Act.count') do
      click_on "Сохранить"
    end

    new_action = Act.last
    assert_equal 9, new_action.value
    assert_equal "Программирование на Ruby", new_action.name
    assert_equal "Подготовка к экзамену по программированию", new_action.desc
    assert_equal @category.id, new_action.category_id

  end

  # переключение языка интерфейса на главной странице
  test "language switch" do
    # вход на главную страницу
    visit acts_url
    # переключение языка на английский
    select "Eng", from: "lang-select"
    # проверка изменения языка интерфейса
    assert_text "Actions List"
    # переключение языка на русский
    select "Rus", from: "lang-select"
    # проверка изменения языка интерфейса
    assert_text "Список активностей"

  end
end
