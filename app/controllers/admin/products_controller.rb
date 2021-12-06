class Admin::ProductsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_product, only: [:edit, :update, :show, :destroy]

  include ColSearchSort

  def index
    @products = search_sort_pagination(params[:query], Product)
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      format.json
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: " your product has been created "
    else
      render 'new'
    end
  end

  def edit; end

  def show; end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "product has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product has been deleted"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :status, :category_id, :coupon_id, main_images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
end
