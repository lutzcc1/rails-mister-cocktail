class Cocktail < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
end

# cocktail.doses.create(ingredient: ingredient, description: "A lot!")
