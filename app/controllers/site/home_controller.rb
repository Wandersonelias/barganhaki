class Site::HomeController < ApplicationController
  layout "site"
  def index
    @categories = Category.all
    @products = Product.last_nine
  end
end
