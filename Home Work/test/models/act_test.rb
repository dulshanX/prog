# тестирование модели активностей Act

require 'test_helper'

class ActTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = categories(:one)
  end

  test 'action valid' do
    # образец правильно заполненной записи
    action = Act.new(user: @user, name: 'Ruby programming', category_id: @category.id, value: 7.2)
    assert action.valid?
  end

  test 'action user invalid' do
    # пользователь не указан
    action = Act.new(name: 'Ruby programming', category_id: @category.id, value: 7.2)
    assert_not action.valid?
  end

  test 'action category invalid' do
    # категория не указана
    action = Act.new(user: @user, name: 'Ruby programming', value: 7.2)
    assert_not action.valid?
  end

  test 'action name invalid' do
    # название отсутствует
    action = Act.new(user: @user, category_id: @category.id, value: 7.2)
    assert_not action.valid?
    # название слишком короткое
    action = Act.new(user: @user, name: 'Ru', category_id: @category.id, value: 7.2)
    assert_not action.valid?
    # название слишком длинное
    action = Act.new(user: @user, name: 'x' * 101, category_id: @category.id, value: 7.2)
    assert_not action.valid?
    # название состоит из пробелов
    action = Act.new(user: @user, name: '   ', category_id: @category.id, value: 7.2)
    assert_not action.valid?
  end

  test 'action value invalid' do
    # значение отсутствует
    action = Act.new(user: @user, name: 'Ruby programming', category_id: @category.id)
    assert_not action.valid?
    # значение не является числом
    action = Act.new(user: @user, name: 'Ruby programming', category_id: @category.id, value: "строка")
    assert_not action.valid?
    # значение слишком маленькое
    action = Act.new(user: @user, name: 'Ruby programming', category_id: @category.id, value: 0)
    assert_not action.valid?
    # значение слишком большое
    action = Act.new(user: @user, name: 'Ruby programming', category_id: @category.id, value: 99)
    assert_not action.valid?
  end

  test 'action added' do
    # проверка на сохранение
    action = Act.create(user: @user, name: 'Ruby programming', category_id: @category.id, value: 7.2)
    found = Act.last
    assert_equal action, found
  end

end
