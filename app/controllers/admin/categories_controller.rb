class Admin::CategoriesController< ApplicationController

  def index
    @categories= Category.all
  end

  def new
    @category= Category.new
  end

  def show
    @category= Category.find(params[:id])
  end

  def edit
    @category= Category.find(params[:id])
  end

  def create
     @category= Category.new(permitted_values)

    if @category.save
      redirect_to admin_categories_path,:notice " your Category has been created "
    else
      render template: "new"
    end
  end

  def update
    @category= Category.find(params[:id])

    if @category.update(permitted_values)
      redirect_to admin_categories_path, :notice "User has been updated"
    else
      render template: "edit"
    end
  end

  private

  def permitted_values
    params.require(:category).permit(:name)
  end

end
