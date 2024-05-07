class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_photo
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(
      product_params
    )

    return redirect_to products_path, notice: t(".created") if @product.save

    render :new, status: :unprocessable_entity
  end

  def edit
    product
  end

  def update
    return redirect_to products_path, notice: t(".updated") if product.update(product_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    product.destroy
  
    redirect_to products_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(
      :title, :description, :price, :photo
    )
  end

  def product
    @product = Product.find(
      params[:id]
    )    
  end
end
