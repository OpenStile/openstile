module RecommendationsHelper
  
  def process_recommendations shopper
    size_matches = matches_for_size shopper.style_profile
    budget_matches = matches_for_budget shopper.style_profile
    look_matches = matches_for_look shopper.style_profile

    return size_matches & budget_matches & look_matches
  end

  def matches_for_size style_profile
    sizes = style_profile.top_sizes + 
            style_profile.bottom_sizes + 
            style_profile.dress_sizes
    sizes.map{|size| size.retailers}.flatten.uniq
  end

  def matches_for_budget style_profile
    match_top_budget = PriceRange.overlap_with_top_budget(style_profile.budget).map(&:retailer).uniq
    match_bottom_budget = PriceRange.overlap_with_bottom_budget(style_profile.budget).map(&:retailer).uniq
    match_dress_budget = PriceRange.overlap_with_dress_budget(style_profile.budget).map(&:retailer).uniq

    match_top_budget | match_bottom_budget | match_dress_budget
  end

  def matches_for_look style_profile
    Retailer.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).map(&:look_id))
  end
end
