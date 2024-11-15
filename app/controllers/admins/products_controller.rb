class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product.order(:position)
  end

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

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admins_root_path, notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
    redirect_to admins_root_path, notice: '削除しました'
  end

  private

  def product_params
    params.expect(product: %i[name price image description position published_at])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
