module ShowPathHelper
  def item_show_path item
    method = "#{item.class.to_s.downcase}_path"
    send(method, item)
  end

  def item_retailer_show_path item
    return item_retailer_show_path(item.retailer) if item.respond_to?(:retailer)
    retailer_path(item)
  end
end
