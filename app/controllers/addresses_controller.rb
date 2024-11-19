class AddressesController < ApplicationController
  def new
    @address = current_user.build_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      # edit作成後、edit画面に遷移
      redirect_to root_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.expect(address: %i[zip_code prefecture city street building])
  end
end
