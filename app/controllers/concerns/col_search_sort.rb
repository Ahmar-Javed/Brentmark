module ColSearchSort
  extend ActiveSupport::Concern

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def search_sort_pagination(query, classname)
    @data = classname.all
    if query.present?
      @data = classname.paginate(page: params[:page], per_page: 5).search(query)
    else
      @data = classname.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 5)
    end
  end
end
