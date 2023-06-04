module Potepan::ProductDecorator
  def relation_products
    Spree::Product
    .joins(:taxons)
    .where(spree_products_taxons: { taxon_id: taxons })
    .where.not(id: id)
    .distinct
    .order(:id)
    .limit(Const::RELATION_PRODUCTS_COUNT)
  end
  Spree::Product.prepend self
end
