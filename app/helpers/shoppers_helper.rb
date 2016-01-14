module ShoppersHelper
  def never_had_drop_in? shopper
    shopper.drop_ins.empty?
  end

  def shopper_store_incompatibilities(shopper, retailer)
    ret = []

    shopper_budget_average = ((shopper.style_profile.top_budget_index || 1).to_f +
        (shopper.style_profile.bottom_budget_index || 1).to_f +
        (shopper.style_profile.dress_budget_index || 1).to_f)/3.0
    multiplier = StyleProfile::MAX_BUDGET_INDEX.to_f/Retailer::MAX_PRICE_RANGE_INDEX.to_f
    normalized_lower_bound = ([0, retailer.price_index - 1].max).to_f * multiplier
    normalized_upper_bound = retailer.price_index.to_f * multiplier

    unless shopper_budget_average >= normalized_lower_bound && shopper_budget_average <= normalized_upper_bound
      ret << 'This store is out of your typical price range'
    end

    shopper_generic_sizes = (shopper.style_profile.top_sizes +
        shopper.style_profile.bottom_sizes +
        shopper.style_profile.dress_sizes).map{|size| size.name.match(Retailer::GENERIC_SIZE_REGEX)[0]}.uniq
    lower_bound_size, upper_bound_size = retailer.size_range.split('-').map{|size| size.match(Retailer::GENERIC_SIZE_REGEX)[0]}

    unless shopper_generic_sizes.any?{|size| Retailer::ORDERED_SIZES.index(size) >= Retailer::ORDERED_SIZES.index(lower_bound_size) &&
        Retailer::ORDERED_SIZES.index(size) <= Retailer::ORDERED_SIZES.index(upper_bound_size)}
      ret << 'This store is out of your typical size range'
    end

    ret
  end
end
