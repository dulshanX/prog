# тестирование модели пользователей User

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'user valid' do
    # образец правильно заполненной записи
    user = User.new(email: 'test@gmail.com', password: 'qwerty', name: 'Михаил Петров')
    assert user.valid?
  end

  test 'user email invalid' do
    # нет почты
    user = User.new(password: 'qwerty')
    assert_not user.valid?
    # почта в неправильном формате
    user = User.new(email: 'testgmail.com', password: 'qwerty')
    assert_not user.valid?
  end

  test 'user password invalid' do
    # нет пароля
    user = User.new(email: 'test@gmail.com')
    assert_not user.valid?
    # слишком короткий пароль
    user = User.new(email: 'test@gmail.com', password: '123')
    assert_not user.valid?
  end

  test 'user name invalid' do
    # пустое имя
    user = User.new(email: 'test@gmail.com', password: 'qwerty', name: '')
    assert_not user.valid?
    # слишком короткое имя
    user = User.new(email: 'test@gmail.com', password: 'qwerty', name: 'ab')
    assert_not user.valid?
    # слишком долинное имя
    user = User.new(email: 'test@gmail.com', password: 'qwerty', name: 'abdfsdfdksfjsd;fjdfjdfkjkj')
    assert_not user.valid?
  end

  test 'user added' do
    # проверка на сохранение
    user = User.create(email: 'test@gmail.com', password: 'qwerty')
    found = User.find_by(email: 'test@gmail.com')
    assert_equal user, found
  end

  test 'user duplicates are prohibited' do
    # пользователи должны быть уникальными
    user1 = User.new(email: 'test@gmail.com', password: 'qwerty')
    assert user1.save
    user2 = User.new(email: 'test@gmail.com', password: '123456')
    assert_not user2.save
  end

end
