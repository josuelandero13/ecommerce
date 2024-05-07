class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
    category
  end

  def create
    @category = Category.new(category_params)

    return redirect_to categories_url, notice: t(".created") if @category.save

    render :new, status: :unprocessable_entity
  end

  def update
    return redirect_to categories_url, notice: t(".updated") if category.update(category_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    category.destroy!

    redirect_to categories_url, notice: t(".destroyed")
  end

  private
    def category
      @category = Category.find(
        params[:id]
      )
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
