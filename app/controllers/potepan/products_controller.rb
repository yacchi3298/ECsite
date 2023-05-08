class Potepan::ProductsController < ApplicationController
  def show
    @products = Spree::Product.find(params[:id])
  end
end
