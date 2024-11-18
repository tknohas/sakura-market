class Admins::Products::PublishesController < Admins::ApplicationController
  before_action :set_product, only: %i[update destroy]

  def update
    @product.update!(published_at: Time.current)
    redirect_to admins_product_path(@product), notice: '公開しました'
  end

  def destroy
    @product.update!(published_at: nil)
    redirect_to admins_product_path(@product), notice: '非公開にしました'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
