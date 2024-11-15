class Admins::ProductsController < Admins::ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admins_root_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.expect(product: [:name, :price, :image, :description, :position, :published_at])
  end
end
