class Category < ApplicationRecord
  has_many :acts

  validates :name, length: { in: 3..30 }
  validates :name, presence: true # имя не может состоять из пробелов
end
