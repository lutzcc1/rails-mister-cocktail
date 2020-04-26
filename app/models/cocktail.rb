class Cocktail < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_one_attached :image
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  accepts_nested_attributes_for :doses, allow_destroy: true
end
