module ItemsHelper
  
  def items_ranked_by_popularity
    ret = Top.all_live + Bottom.all_live +
          Dress.all_live + Outfit.all_live 
    ret.sort_by{|item| item.interested_shoppers.count}.reverse
  end

  def item_favorite_toggle_path item
    type = item.class.name.downcase
    method = "toggle_favorite_#{type}_path"
    send(method, item)
  end
end
