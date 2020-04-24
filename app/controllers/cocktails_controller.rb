require "byebug"
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
    params[:cocktail][:name] = params[:cocktail][:name].downcase.titleize
    params.require(:cocktail).permit(:name)
  end

  def add_doses
    @cocktail.doses.destroy_all
    # missing _destroy
    strong_params = params.require(:cocktail).permit(doses_attributes: [:description, :ingredient_id])
    params[:cocktail][:doses_attributes].each_key do |key|
      @cocktail.doses.create(strong_params[:doses_attributes][key])
    end
  end
end
