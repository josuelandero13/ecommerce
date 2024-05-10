class ProductsController < ApplicationController
  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_photo.order(created_at: :desc).load_async
    @products = Product.where(category_id: params[:category_id]) if params[:category_id]
    @products = Product.where("price >= ?", params[:min_price]) if params[:min_price].present?
    @products = Product.where("price <= ?", params[:max_price]) if params[:max_price].present?
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
      :title, :description, :price, :photo, :category_id
    )
  end

  def product
    @product = Product.find(
      params[:id]
    )
  end
end
