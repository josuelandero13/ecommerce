# frozen_string_literal: true

# Product Controller
class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: %i[index show]

  def index
    @categories = Category.order(name: :asc).load_async
    @pagy, @products = pagy_countless(
      FindProduct.new.call(product_params_index), items: 12
    )
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

    return redirect_to products_path, notice: t('.created') if @product.save

    render :new, status: :unprocessable_entity
  end

  def edit
    authorize! product
  end

  def update
    authorize! product

    return redirect_to products_path, notice: t('.updated') if product.update(product_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    authorize! product

    product.destroy

    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(
      :title, :description, :price, :photo, :category_id
    )
  end

  def product_params_index
    params.permit(
      :category_id, :min_price, :max_price, :query_text, :order_by, :page
    )
  end

  def product
    @product = Product.find(
      params[:id]
    )
  end
end
