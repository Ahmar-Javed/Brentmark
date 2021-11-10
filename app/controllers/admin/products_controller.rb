class Admin::ProductsController < ApplicationController 
  helper_method :sort_column, :sort_direction
  
  def index
    if params[:query].present?
       @products = Product.paginate(page: params[:page], per_page: 3).search_products(params[:query])
    else
      @products = Product.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 3)
      respond_to do |format|
        format.html
        format.csv {send_data @products.to_csv}
      end
    end
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

   def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
  Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

end
