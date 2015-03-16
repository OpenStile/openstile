module ItemsHelper
  
  def items_ranked_by_popularity
    ranking = Favorite.group(:favoriteable_id, :favoriteable_type)
                      .count.sort_by{|k,v| v}.reverse
    items = ranking.map{|entry| entry[0][1].constantize.find(entry[0][0])}

    items | (Top.all_live + Bottom.all_live + Dress.all_live + Outfit.all_live)
  end

  def item_favorite_toggle_path item
    type = item.class.name.downcase
    method = "toggle_favorite_#{type}_path"
    send(method, item)
  end
end
