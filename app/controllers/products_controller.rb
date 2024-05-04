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

  private

  def product_params
    params.require(:product).permit(
      :title, :description, :price
    )
  end
end
