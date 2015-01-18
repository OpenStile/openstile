require 'rails_helper'

feature 'Style Feed retailer matching' do
  let(:retailer){ FactoryGirl.create(:retailer) }  
  let(:shopper){ FactoryGirl.create(:shopper) }  

  scenario 'based on size' do
    calibrate_shopper_and_retailer_except_for :size

    original_sizes = seed_sizes({top_size: "Small", bottom_size: "Small", dress_size: "Small"})
    new_sizes = seed_sizes({top_size: "Large", bottom_size: "Large", dress_size: "Large"})

    set_sizes_for_retailer new_sizes

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_sizes_to original_sizes
    then_my_style_feed_should_not_contain retailer
    when_i_set_my_style_profile_sizes_to new_sizes
    then_my_style_feed_should_contain retailer
  end

  scenario 'based on budget' do
    calibrate_shopper_and_retailer_except_for :budget

    original_budget = {top: "$50 - $100", bottom: "$50 - $100", dress: "$50 - $100"}
    new_budget = {top: "$150 - $200", bottom: "$150 - $200", dress: "$200 +"}

    set_price_range_for_retailer({top: ["200.00", "500.00"], bottom: ["300.00", "600.00"], dress: ["500.00", "1000.00"]})

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_budget_to original_budget
    then_my_style_feed_should_not_contain retailer
    when_i_set_my_style_profile_budget_to new_budget
    then_my_style_feed_should_contain retailer
  end

  scenario 'based on hated look' do
    calibrate_shopper_and_retailer_except_for :hated_look

    look = FactoryGirl.create(:look, name: "Bohemian Chic")
    
    set_retailer_primary_look look

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_look_as look, :hate
    then_my_style_feed_should_not_contain retailer
    when_i_set_my_style_profile_feelings_for_a_look_as look, :impartial
    then_my_style_feed_should_contain retailer
  end

  private
    
    def seed_sizes size_hash
      ret = {}
      size_hash.each do |type, size| 
        generated = FactoryGirl.create(type, name: size)
        ret[type] = generated
      end
      ret
    end

    def set_sizes_for_retailer sizes
      retailer.top_sizes << sizes[:top_size]
      retailer.bottom_sizes << sizes[:bottom_size]
      retailer.dress_sizes << sizes[:dress_size]
    end

    def set_price_range_for_retailer price_ranges
      retailer.price_range.update!({top_min_price: price_ranges[:top][0],
                                    top_max_price: price_ranges[:top][1],
                                    bottom_min_price: price_ranges[:bottom][0],
                                    bottom_max_price: price_ranges[:bottom][1],
                                    dress_min_price: price_ranges[:dress][0],
                                    dress_max_price: price_ranges[:dress][1]})
    end

    def set_retailer_primary_look look
      retailer.look = look
      retailer.save
    end

    def calibrate_shopper_and_retailer_except_for tested_property
      unless tested_property == :size
        shared_size = FactoryGirl.create(:top_size)
        shopper.style_profile.top_sizes << shared_size
        retailer.top_sizes << shared_size
      end

      unless tested_property == :budget
        shopper.style_profile.budget.top_min_price = 50.00
        retailer.price_range.top_min_price = 50.00
        shopper.style_profile.budget.top_max_price = 100.00
        retailer.price_range.top_max_price = 100.00
        shopper.style_profile.budget.save
        retailer.price_range.save
      end

      unless tested_property == :hated_look
        bad_look = FactoryGirl.create(:look, name: "Look I don't like")
        indifferent_look = FactoryGirl.create(:look, name: "Look I can take or leave")
        shopper.style_profile.look_tolerances.create(look_id: indifferent_look.id, 
                                                     tolerance: 5)
        shopper.style_profile.look_tolerances.create(look_id: bad_look.id, 
                                                     tolerance: 1)

        # Ensure that retailer with no look isn't filtered out                                                      
        retailer.update!(look_id: nil)                                                      
      end
    end
end
