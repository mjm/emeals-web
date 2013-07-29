module ApplicationHelper
  include FoundationHelper

  def icon(klass)
    "<i class=\"foundicon-#{klass}\"></i>".html_safe
  end
end
