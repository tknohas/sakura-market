class AddressesController < ApplicationController
  before_action :set_address, only: %i[edit update]

  def new
    @address = current_user.build_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      redirect_to edit_address_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      ridirect_to edit_address_path, notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.expect(address: %i[zip_code prefecture city street building])
  end

  def set_address
    @address = current_user.address
  end
end
