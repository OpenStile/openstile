module RecommendationsHelper

  ITEM_PRICE_RANGE_FUZZ = 50
  
  def process_recommendations shopper
    retailer_size_matches, item_size_matches = matches_for_size shopper.style_profile
    retailer_budget_matches, item_budget_matches = matches_for_budget shopper.style_profile
    retailer_look_matches, item_look_matches = matches_for_look shopper.style_profile
    item_coverage_matches = matches_for_coverage shopper.style_profile

    retailer_recommendations = (retailer_size_matches & retailer_budget_matches & retailer_look_matches) 
    item_recommendations = (item_size_matches & item_budget_matches & item_look_matches & item_coverage_matches) 

    retailer_recommendations + item_recommendations
  end

  def matches_for_size style_profile
    top_sizes = style_profile.top_sizes
    bottom_sizes = style_profile.bottom_sizes
    dress_sizes = style_profile.dress_sizes

    retailers = (top_sizes + bottom_sizes + dress_sizes).map(&:retailers).flatten.uniq

    tops = top_sizes.map(&:tops).flatten.uniq
    bottoms = bottom_sizes.map(&:bottoms).flatten.uniq
    dresses = dress_sizes.map(&:dresses).flatten.uniq
    
    [retailers, (tops + bottoms + dresses)]
  end

  def matches_for_budget style_profile
    retailer_match_top_budget = PriceRange.overlap_with_top_budget(style_profile.budget).map(&:retailer).uniq
    retailer_match_bottom_budget = PriceRange.overlap_with_bottom_budget(style_profile.budget).map(&:retailer).uniq
    retailer_match_dress_budget = PriceRange.overlap_with_dress_budget(style_profile.budget).map(&:retailer).uniq

    retailers = retailer_match_top_budget | retailer_match_bottom_budget | retailer_match_dress_budget

    tops = Top.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    bottoms = Bottom.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    dresses = Dress.within_budget(style_profile.budget, ITEM_PRICE_RANGE_FUZZ)
    
    [retailers, (tops + bottoms + dresses)]
  end

  def matches_for_look style_profile
    retailers = Retailer.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))

    tops = Top.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    bottoms = Bottom.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    dresses = Dress.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    
    [retailers, (tops + bottoms + dresses)]
  end

  def matches_for_coverage style_profile
    tops = Top.where.not(id: Top.joins(:exposed_parts)
                                 .where(exposed_parts: { part_id: PartExposureTolerance.parts_to_cover_for(style_profile.id).pluck(:part_id)})
                                 .pluck(:id))
    bottoms = Bottom.where.not(id: Bottom.joins(:exposed_parts)
                                         .where(exposed_parts: { part_id: PartExposureTolerance.parts_to_cover_for(style_profile.id).pluck(:part_id)})
                                         .pluck(:id))
    dresses = Dress.where.not(id: Dress.joins(:exposed_parts)
                                       .where(exposed_parts: { part_id: PartExposureTolerance.parts_to_cover_for(style_profile.id).pluck(:part_id)})
                                       .pluck(:id))

    tops + bottoms + dresses
  end
end
