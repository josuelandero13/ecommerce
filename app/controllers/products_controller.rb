# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_photo
    @products = @products.where(category_id: params[:category_id]) if params[:category_id]
    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?
    @products = @products.search_full_text(params[:query_text]) if params[:query_text].present?

    order_by = Product::ORDER_BY.fetch(
      params[:order_by]&.to_sym, Product::ORDER_BY[:newest]
    )

    @products = @products.order(order_by).load_async

    @pagy, @products = pagy_countless(@products, items: 12)
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
    product
  end

  def update
    return redirect_to products_path, notice: t('.updated') if product.update(product_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    product.destroy

    redirect_to products_path, notice: t('.destroyed'), status: :see_other
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
