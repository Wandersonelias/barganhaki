class Site::Profile::DashboardController < ApplicationController
  layout 'profile'
  def index
    @products = Product.all
    @categories = Category.all
  end
end 
