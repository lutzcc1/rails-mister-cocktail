class Cocktail < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  # rejects blank description provided in form
  # accepts_nested_attributes_for :doses,
  #                               reject_if: lambda do |attributes|
  #                                 attributes[:description].blank?
  #                               end
end

# cocktail.doses.create(ingredient: ingredient, description: "A lot!")
