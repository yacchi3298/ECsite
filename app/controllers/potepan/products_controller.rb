class Potepan::ProductsController < ApplicationController
  def show
    #binding.pry
    @product = Spree::Product.find(params[:id])
    #binding.pry
  end
end
