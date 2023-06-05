class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxon = @product.taxons.first
    @related_products = @product.relation_products.
      includes(master: [:images, :default_price]).
      limit(Const::RELATION_PRODUCTS_COUNT)
  end
end
