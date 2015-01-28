module RecommendationsHelper

  ITEM_PRICE_RANGE_FUZZ = 50
  
  def process_recommendations shopper
    retailer_size_matches, item_size_matches = matches_for_size shopper.style_profile
    retailer_budget_matches, item_budget_matches = matches_for_budget shopper.style_profile
    retailer_look_matches, item_look_matches = matches_for_look shopper.style_profile
    item_coverage_matches = matches_for_coverage shopper.style_profile
    item_color_matches = matches_for_color shopper.style_profile
    item_print_matches = matches_for_print shopper.style_profile

    retailer_matches = (retailer_size_matches & retailer_budget_matches & retailer_look_matches) 
    item_matches = (item_size_matches & item_budget_matches & item_look_matches & 
                            item_coverage_matches & item_color_matches & item_print_matches) 

    process_rankings(shopper.style_profile, (retailer_matches + item_matches))
  end
  
  def process_rankings style_profile, recommendations
    results = []
    recommendations.each do |recommendation_object|
      recommendation = {priority: 0, 
                        justification: [], 
                        object: recommendation_object}

      recommendation = evaluate_body_shape recommendation, style_profile
      recommendation = evaluate_body_build recommendation, style_profile
      recommendation = evaluate_favorite_looks recommendation, style_profile
      recommendation = evaluate_top_fit recommendation, style_profile
      recommendation = evaluate_bottom_fit recommendation, style_profile
      recommendation = evaluate_special_considerations recommendation, style_profile
      recommendation = evaluate_parts_to_show_off recommendation, style_profile
      recommendation = evaluate_favorite_prints recommendation, style_profile

      results << recommendation
    end
    results.sort{|rec1, rec2| rec2[:priority] <=> rec1[:priority]}
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
    retailers = Retailer.where(look_id: nil) + Retailer.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))

    tops = Top.where(look_id: nil) + Top.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    bottoms = Bottom.where(look_id: nil) + Bottom.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    dresses = Dress.where(look_id: nil) + Dress.where.not(look_id: LookTolerance.hated_looks_for(style_profile.id).pluck(:look_id))
    
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

  def matches_for_color style_profile
    tops = Top.where(color_id: nil) + Top.where.not(color_id: style_profile.avoided_color_ids)
    bottoms = Bottom.where(color_id: nil) + Bottom.where.not(color_id: style_profile.avoided_color_ids)
    dresses = Dress.where(color_id: nil) + Dress.where.not(color_id: style_profile.avoided_color_ids)

    tops + bottoms + dresses
  end

  def matches_for_print style_profile
    tops = Top.where(print_id: nil) + Top.where.not(print_id: PrintTolerance.hated_prints_for(style_profile.id).pluck(:print_id))
    bottoms = Bottom.where(print_id: nil) + Bottom.where.not(print_id: PrintTolerance.hated_prints_for(style_profile.id).pluck(:print_id))
    dresses = Dress.where(print_id: nil) + Dress.where.not(print_id: PrintTolerance.hated_prints_for(style_profile.id).pluck(:print_id))

    tops + bottoms + dresses
  end

  def evaluate_body_shape recommendation, style_profile
    return recommendation if style_profile.body_shape_id.nil?
    if recommendation[:object].body_shape_id == style_profile.body_shape_id
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Body Type"
    end
    recommendation
  end

  def evaluate_body_build recommendation, style_profile
    if (recommendation[:object].for_petite && style_profile.is_petite? || 
        recommendation[:object].for_tall && style_profile.is_tall? ||
        recommendation[:object].for_full_figured && style_profile.body_build == "Full-figured") 

      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Body Type"
    end
    recommendation
  end

  def evaluate_favorite_looks recommendation, style_profile
    if LookTolerance.favorite_looks_for(style_profile).pluck(:look_id).include?(recommendation[:object].look_id)
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Favorite Looks"
    end
    recommendation
  end

  def evaluate_top_fit recommendation, style_profile
    return recommendation if recommendation[:object].is_a? Bottom
    return recommendation if style_profile.top_fit.blank?
    if (recommendation[:object].top_fit == style_profile.top_fit)
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Preferred Fit"
    end
    recommendation
  end

  def evaluate_bottom_fit recommendation, style_profile
    return recommendation if recommendation[:object].is_a? Top
    return recommendation if style_profile.bottom_fit.blank?
    if (recommendation[:object].bottom_fit == style_profile.bottom_fit)
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Preferred Fit"
    end
    recommendation
  end

  def evaluate_special_considerations recommendation, style_profile
    overlap = style_profile.special_consideration_ids & recommendation[:object].special_consideration_ids

    recommendation[:priority] = recommendation[:priority] + 1 unless overlap.empty?
  
    overlap.each do |id|
      recommendation[:justification] << SpecialConsideration.find(id).name
    end
    recommendation
  end

  def evaluate_parts_to_show_off recommendation, style_profile
    return recommendation if recommendation[:object].is_a? Retailer

    parts_to_flaunt_ids = PartExposureTolerance.parts_to_flaunt_for(style_profile).pluck(:part_id)
    parts_exposed_ids = recommendation[:object].exposed_parts.pluck(:part_id)

    unless (parts_to_flaunt_ids & parts_exposed_ids).empty?
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Preferred Fit"
    end
    recommendation
  end

  def evaluate_favorite_prints recommendation, style_profile
    return recommendation if recommendation[:object].is_a? Retailer
    if PrintTolerance.favorite_prints_for(style_profile).pluck(:print_id).include?(recommendation[:object].print_id)
      recommendation[:priority] = recommendation[:priority] + 1
      recommendation[:justification] << "your Preferred Prints and Patterns"
    end
    recommendation
  end

  def store_recommendation_of_interest recommendation
    session[:return_to_rec] = "#{recommendation.class.to_s.downcase}_#{recommendation.id}" 
  end

  def retrieve_recommendation_of_interest_path
    return_path = "#{root_path}##{session[:return_to_rec]}"
    session.delete(:return_to_rec)
    return_path
  end
end
