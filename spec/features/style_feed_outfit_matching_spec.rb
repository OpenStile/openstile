require 'rails_helper'

feature 'Style Feed item matching' do
  let(:retailer){ FactoryGirl.create(:retailer) }  
  let(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }  

  scenario 'based on size' do
    calibrate_shopper_and_outfit_except_for :size

    original_sizes = {top_size: FactoryGirl.create(:top_size, name: "Small"), 
                      bottom_size: FactoryGirl.create(:bottom_size, name: "Small"),
                      dress_size: FactoryGirl.create(:dress_size, name: "Small")}

    new_sizes =  {top_size: FactoryGirl.create(:top_size, name: "Large"), 
                      bottom_size: FactoryGirl.create(:bottom_size, name: "Large"),
                      dress_size: FactoryGirl.create(:dress_size, name: "Large")}                      

    outfit.top_sizes << new_sizes[:top_size]
    outfit.bottom_sizes << new_sizes[:bottom_size]
    outfit.dress_sizes << new_sizes[:dress_size]

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_sizes_to original_sizes
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_sizes_to new_sizes
    then_my_style_feed_should_contain outfit
  end

  scenario 'based on budget' do
    calibrate_shopper_and_outfit_except_for :budget
    
    original_budget = {top: "$50 - $100", bottom: "$50 - $100", dress: "$50 - $100"}
    new_budget = {top: "$150 - $200", bottom: "$150 - $200", dress: "$200 +"}

    # Note a fuzz is used when evaluating price matches
    outfit.update!(average_price: 175.50)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_budget_to original_budget
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_budget_to new_budget
    then_my_style_feed_should_contain outfit
  end

  scenario 'based on hated look' do
    calibrate_shopper_and_outfit_except_for :hated_look

    look = FactoryGirl.create(:look, name: "Bohemian Chic")

    outfit.update!(look_id: look.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_look_as look, :hate
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_feelings_for_a_look_as look, :impartial
    then_my_style_feed_should_contain outfit
  end

  scenario 'based on parts to cover' do
    calibrate_shopper_and_outfit_except_for :hated_look

    midsection = FactoryGirl.create(:part, name: "Midsection")
    legs = FactoryGirl.create(:part, name: "Legs")

    FactoryGirl.create(:exposed_part, part: legs, exposable: outfit)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_coverage_preference_as [midsection, legs], :cover
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_coverage_preference_as [legs], :impartial
    then_my_style_feed_should_contain outfit
  end

  scenario 'based on colors to avoid' do
    calibrate_shopper_and_outfit_except_for :color_to_avoid

    color = FactoryGirl.create(:color)

    outfit.colors << color
    
    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_avoided_colors color, :check
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_avoided_colors color, :uncheck
    then_my_style_feed_should_contain outfit
  end

  scenario 'based on hated print' do
    calibrate_shopper_and_outfit_except_for :hated_print

    print = FactoryGirl.create(:print, name: "Animal Print")

    outfit.prints << print

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_print_as print, :hate
    then_my_style_feed_should_not_contain outfit
    when_i_set_my_style_profile_feelings_for_a_print_as print, :impartial
    then_my_style_feed_should_contain outfit
  end

  private
    def calibrate_shopper_and_outfit_except_for tested_property
      unless tested_property == :hated_look
        bad_look = FactoryGirl.create(:look, name: "Look I don't like")
        indifferent_look = FactoryGirl.create(:look, name: "Look I can take or leave")
        shopper.style_profile.look_tolerances.create(look_id: indifferent_look.id, 
                                                     tolerance: 5)
        shopper.style_profile.look_tolerances.create(look_id: bad_look.id, 
                                                     tolerance: 1)

        # Ensure that outfits with non-hated looks or no look aren't filtered out                                                      
        outfit.update!(look_id: indifferent_look.id)                                                     
      end

      unless tested_property == :part_coverage
        part_to_cover = FactoryGirl.create(:part, name: "Part to cover")
        part_i_show = FactoryGirl.create(:part, name: "Part I show")
        shopper.style_profile.part_exposure_tolerances.create(part_id: part_to_cover.id,
                                                              tolerance: 1)
        shopper.style_profile.part_exposure_tolerances.create(part_id: part_i_show.id,
                                                              tolerance: 5)

        # Ensure that outfit exposing parts I don't mind showing or 
        # that expose nothing aren't filtered out                                                      
        outfit.exposed_parts.create(part_id: part_i_show.id)
      end

      unless tested_property == :color_to_avoid
        hated_color = FactoryGirl.create(:color, name: "Color I don't like")
        indifferent_color = FactoryGirl.create(:color, name: "Color I don't hate")
        shopper.style_profile.avoided_colors << hated_color

        # Ensure that outfit with non-hated color or no primary color aren't filtered out                                                      
        outfit.colors << indifferent_color
      end

      unless tested_property == :hated_print
        bad_print = FactoryGirl.create(:print, name: "Print I don't like")
        indifferent_print = FactoryGirl.create(:print, name: "Print I can take or leave")
        shopper.style_profile.print_tolerances.create(print_id: indifferent_print.id, 
                                                     tolerance: 5)
        shopper.style_profile.print_tolerances.create(print_id: bad_print.id, 
                                                     tolerance: 1)

        # Ensure that outfit with non-hated prints or no print aren't filtered out                                                      
        outfit.prints << indifferent_print
      end

      unless tested_property == :size
        shared_size = FactoryGirl.create(:top_size)
        shopper.style_profile.top_sizes << shared_size
        outfit.top_sizes << shared_size
      end

      unless tested_property == :budget
        shopper.style_profile.budget.update!(top_min_price: 50.00, 
                                             top_max_price: 100.00,
                                             bottom_min_price: 50.00, 
                                             bottom_max_price: 100.00,
                                             dress_min_price: 50.00, 
                                             dress_max_price: 100.00)
        outfit.update!(average_price: 75.00)
      end
    end
end
