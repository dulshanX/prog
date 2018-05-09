# тестирование контроллера статистики StatsController, включая Ajax-запросы

require 'test_helper'

class StatsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    # успешная выдача страницы статистики
    get stats_url
    assert_response :success
  end

  # тестирование Ajax-запросов, метод filter()
  test "ajax requests" do
    # параметры по умолчанию: только 2 даты
    post stats_filter_url, params: { date1: '2017-12-01', date2: '2017-12-31' }, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    if assert_equal 2, json_response.length # 2 записи в fixtures для указанного интервала
      assert_equal 'Action One', json_response[0]["name"] # проверка на конкретные значения
      assert_equal 'Action Two', json_response[1]["name"] # 
    end
    # если не указаны даты, должны выводиться все записи
    post stats_filter_url, params: {}, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    assert_equal 6, json_response.length
    # поиск по имени; регистр букв не имеет значения
    post stats_filter_url, params: { name: 'action four' }, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    if assert_equal 1, json_response.length
      assert_equal 4.525, json_response[0]["value"] # проверка на конкретные значения
    end
    # поиск по категории
    post stats_filter_url, params: { cat_id: categories(:two).id.to_s }, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    assert_equal 3, json_response.length # 3 записи с категорией two
    post stats_filter_url, params: { cat_id: categories(:three).id.to_s }, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    assert_equal 1, json_response.length # 1 запись с категорией three
    # поиск по имени пользователя
    post stats_filter_url, params: { username: users(:one).name }, xhr: true, as: :json
    json_response = JSON.parse(@response.body)
    assert_equal 4, json_response.length # 4 записи от пользователя :one
  end

end
