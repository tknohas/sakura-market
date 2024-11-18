class Admins::Products::PublishesController < Admins::ApplicationController
  def update
    @product = Product.find(params[:product_id])
    @product.update!(published_at: Time.current)
    redirect_to admins_product_path(@product), notice: '公開しました'
  end
end
