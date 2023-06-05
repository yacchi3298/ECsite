module Potepan::ProductDecorator
  def relation_products
    Spree::Product.
      in_taxons(taxons).
      includes(master: [:images, :default_price]).
      where.not(id: id).
      distinct.
      order(:id).
      limit(Const::RELATION_PRODUCTS_COUNT)
  end
  Spree::Product.prepend self
end
