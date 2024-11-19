class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.published.page(params[:page])
  end
end
