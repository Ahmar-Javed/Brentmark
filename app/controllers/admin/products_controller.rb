class Admin::ProductsController < ApplicationController 
  
  def index
    @products= Product.all
  end

  def new
    @product= Product.new
  end
 
  def create
    @product= Product.new(permitted_values)

    if @product.save
      redirect_to admin_products_path,notice => " your product has been created "
    else
      render template: "new"
    end
  end


  def edit
    @product= Product.find(params[:id])
  end

  def show
    @product= Product.find(params[:id])
  end

  def update
    @product= Product.find(params[:id])

    if @product.update(permitted_values)
      redirect_to admin_products_path, :notice=> "product has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @product= Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, :notice=> "Product has been deleted"
  end

  private

  def permitted_values
  params.require(:product).permit(:title, :description, :price, :status)
  end

end
