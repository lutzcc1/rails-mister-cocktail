class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update]

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
    if @cocktail.save
      redirect_to cocktails_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    else
      render :edit
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params[:cocktail][:name] = params[:cocktail][:name].downcase.titleize
    params.require(:cocktail)
          .permit(
            :name,
            doses_attributes: [
              :id,
              :_destroy,
              :description,
              :ingredient_id
            ]
          )
  end
end
