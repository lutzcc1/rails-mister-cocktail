
class CocktailsController < ApplicationController
  before_action :set_task, only: %i[show edit update]

  def index
    @cocktails = Cocktail.all
  end

  def show; end

  def new
    @cocktail = Cocktail.new
    @cocktail.doses.build
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save
    add_doses
    redirect_to cocktails_path
  end

  def edit; end

  def update
    @cocktail.update(cocktail_params)
    add_doses
    redirect_to cocktail_path(@cocktail)
  end

  private

  def set_task
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    # why I'm i getting empty elements in the :ingredient_ids string
    params[:cocktail][:ingredient_ids].reject!(&:empty?)
    params[:cocktail][:name] = params[:cocktail][:name].downcase.titleize
    params.require(:cocktail).permit(:name, :doses_attributes, :ingredient_ids)
  end

  def add_doses
     # why I'm i getting empty elements in the :ingredient_ids string
    @cocktail.doses.destroy_all
    ingredient_list = params[:cocktail][:ingredient_ids]
    ingredient_list.each_with_index do |ingredient, num_of_description|
      dose_description = params[:cocktail][:doses_attributes][num_of_description.to_s.to_sym][:description]
      @cocktail.doses.create!(description: dose_description, ingredient_id: ingredient)
    end
  end
end
