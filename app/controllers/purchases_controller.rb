class PurchasesController < ApplicationController
  def new
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.complete!
      current_cart.clear
      redirect_to products_path, notice: '購入しました'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.expect(purchase: %i[delivery_on delivery_time])
  end
end
