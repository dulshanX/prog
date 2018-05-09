class Act < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, length: { in: 3..100 }
  validates :name, presence: true # имя не может состоять из пробелов
  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 24 }
end
