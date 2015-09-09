module ConferencesHelper

  #can't use a query because we want to include price objects that have been built but not persisted yet
  def sorted_regular_prices(conference_item)
    conference_item.prices.select {|price| price.discount_key.blank? ? price : nil}.sort
  end
end
