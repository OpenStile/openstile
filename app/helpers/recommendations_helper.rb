module RecommendationsHelper
  
  def process_recommendations shopper
    size_matches = matches_for_size shopper.style_profile
    return size_matches
  end

  def matches_for_size style_profile
    sizes = style_profile.top_sizes + 
            style_profile.bottom_sizes + 
            style_profile.dress_sizes
    sizes.map{|size| size.retailers}.flatten.uniq
  end
end
