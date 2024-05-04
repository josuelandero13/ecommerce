class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(
      params[:id]
    )
  end

  def new
    @product = Product.new
  end

  def create
    message_notice = "Tu producto se ha creado correctamente"

    @product = Product.new(
      product_params
    )

    return redirect_to products_path, notice: message_notice if @product.save

    render :new, status: :unprocessable_entity
  end

  def edit
    @product = Product.find(
      params[:id]
    )
  end

  def update
    message_update = "Tu producto se ha actualizado correctamente"

    @product = Product.find(
      params[:id]
    )

    return redirect_to products_path, notice: message_update if @product.update(product_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    message_destroy = "Tu producto se ha eliminado correctamente"

    @product = Product.find(
      params[:id]
    )

    @product.destroy
    redirect_to products_path, notice: message_destroy, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(
      :title, :description, :price
    )
  end
end
