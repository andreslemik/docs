module ApplicationHelper
  def icon(name, size)
    content_tag(:i, nil, class: "fi-#{name} icon-#{size}")
  end

  def set_title(value)
    content_for(:title, value)
    wiselinks_title(value)
  end
end
