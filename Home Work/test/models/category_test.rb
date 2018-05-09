# тестирование модели категорий Category

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test 'category valid' do
    # образец правильно заполненной записи
    category = Category.new(name: 'Reading', desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    assert category.valid?
  end

  test 'category name invalid' do
    # название отсутствует
    category = Category.new(desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    assert_not category.valid?
    # название слишком короткое
    category = Category.new(name: 'Re', desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    assert_not category.valid?
    # название слишком длинное
    category = Category.new(name: 'x' * 101, desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    assert_not category.valid?
    # название состоит из пробелов
    category = Category.new(name: '   ', desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    assert_not category.valid?
  end

  test 'category added' do
    # проверка на сохранение
    category = Category.create(name: 'Reading', desc: 'Reading is a complex "cognitive process" of decoding symbols in order to construct or derive meaning (reading comprehension)')
    found = Category.last
    assert_equal category, found
  end

end
