module ApplicationHelper
  def sortable(column, username = nil)
    username ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to username, sort: column, direction: direction
  end
end
