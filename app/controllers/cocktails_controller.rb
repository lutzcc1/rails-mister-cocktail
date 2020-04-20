class CocktailsController < ApplicationController

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
    3.times { @cocktail.doses.build }
  end

  def create
    # why I'm i getting empty elements in the :ingredient_ids string?
    params[:cocktail][:ingredient_ids].reject!(&:empty?)
    params[:cocktail][:name] = params[:cocktail][:name].downcase.titleize

    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save
    add_doses
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def add_doses
    ingredient_list = params[:cocktail][:ingredient_ids]
    ingredient_list.each_with_index do |ingredient, num_of_description|
      dose_description = params[:cocktail][:doses_attributes][num_of_description.to_s.to_sym][:description]
      @cocktail.doses.create!(description: dose_description, ingredient_id: ingredient)
    end
  end
end
