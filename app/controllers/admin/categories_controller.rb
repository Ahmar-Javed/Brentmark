class Admin::CategoriesController< ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  def index
    @categories= Category.all
  end

  def new
    @category= Category.new
  end

  def show
  end

  def edit
  end

  def create
     @category= Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: " your Category has been created "
    else
      render template: "new"
    end
  end

  def update

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "User has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'category is deleted'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category= Category.find(params[:id])
  end

  def check_admin
    unless current_user.admin?
      redirect_to new_admin_user_path
    end
  end
end
