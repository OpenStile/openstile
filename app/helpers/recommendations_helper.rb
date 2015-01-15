module RecommendationsHelper

  ITEM_PRICE_RANGE_FUZZ = 50
  
  def process_recommendations shopper
    size_matches = matches_for_size shopper.style_profile
    budget_matches = matches_for_budget shopper.style_profile
    look_matches = matches_for_look shopper.style_profile

    return size_matches & budget_matches & look_matches
  end

  def matches_for_size style_profile
    top_sizes = style_profile.top_sizes
    bottom_sizes = style_profile.bottom_sizes
    dress_sizes = style_profile.dress_sizes

    retailers = (top_sizes + bottom_sizes + dress_sizes).map{|size| size.retailers}.flatten.uniq

    tops = top_sizes.map{|size| size.tops}.flatten.uniq
    bottoms = bottom_sizes.map{|size| size.bottoms}.flatten.uniq
    dresses = dress_sizes.map{|size| size.dresses}.flatten.uniq
    
    retailers + tops + bottoms + dresses
  end

  def matches_for_budget style_profile
    retailer_match_top_budget = PriceRange.overlap_with_top_budget(style_profile.budget).map(&:retailer).uniq
    retailer_match_bottom_budget = PriceRange.overlap_with_bottom_budget(style_profile.budget).map(&:retailer).uniq
    retailer_match_dress_budget = PriceRange.overlap_with_dress_budget(style_profile.budget).map(&:retailer).uniq

    retailers = retailer_match_top_budget | retailer_match_bottom_budget | retailer_match_dress_budget

    tops = Top.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    bottoms = Bottom.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    dresses = Dress.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    
    retailers + tops + bottoms + dresses
  end

  def matches_for_look style_profile
    retailers = Retailer.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).map(&:look_id))

    # TODO Filter once item look association created
    tops = Top.all
    bottoms = Bottom.all
    dresses = Dress.all
    
    retailers + tops + bottoms + dresses
  end
end
