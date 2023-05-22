class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Taxon.find(params[:id])
  end
end
