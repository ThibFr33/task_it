module ApplicationHelper
  def image_category(category)
    return "#{category}.png"
  end
end

# <%= image_path(image_category(List.category)) %>
