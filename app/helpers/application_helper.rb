module ApplicationHelper
  def flash_class(type)
    case type
    when 'alert'
      'danger'
    when 'notice'
      'success'
    else
      'info'
    end
  end

  def flash_classes(type)
    "alert-#{ flash_class(type) } alert alert-dismissible"
  end
end
