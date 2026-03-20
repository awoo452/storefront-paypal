class HomeController < ApplicationController
  def index
    data = Home::IndexData.call
    @featured_products = data.featured_products
  end
end
