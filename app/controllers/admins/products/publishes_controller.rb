class Admins::Products::PublishesController < Admins::ApplicationController
  def update
    @product = Product.find(params[:product_id])
    if @product.update(published_at: Time.current)
      redirect_to admins_product_path(@product), notice: '公開しました'
    else
      flash_now[:alert] = '公開に失敗しました'
      redirect_to edit_admins_product_path(@product)
    end
  end
end
