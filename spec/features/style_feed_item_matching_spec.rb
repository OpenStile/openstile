require 'rails_helper'

feature 'Style Feed item matching' do
  let(:retailer){ FactoryGirl.create(:retailer) }  
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }  

  scenario 'based on size' do
    calibrate_shopper_and_items_except_for :size

    original_sizes = {top_size: FactoryGirl.create(:top_size, name: "Small"), 
                      bottom_size: FactoryGirl.create(:bottom_size, name: "Small"),
                      dress_size: FactoryGirl.create(:dress_size, name: "Small")}

    new_sizes =  {top_size: FactoryGirl.create(:top_size, name: "Large"), 
                      bottom_size: FactoryGirl.create(:bottom_size, name: "Large"),
                      dress_size: FactoryGirl.create(:dress_size, name: "Large")}                      

    set_sizes_for_items new_sizes                      

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_sizes_to original_sizes
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_sizes_to new_sizes
    then_my_style_feed_should_contain top
    then_my_style_feed_should_contain bottom
    then_my_style_feed_should_contain dress
  end

  scenario 'based on budget' do
    calibrate_shopper_and_items_except_for :budget
    
    original_budget = {top: "$50 - $100", bottom: "$50 - $100", dress: "$50 - $100"}
    new_budget = {top: "$150 - $200", bottom: "$150 - $200", dress: "$200 +"}

    # Note a fuzz is used when evaluating price matches
    set_prices_for_items 175.50

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_budget_to original_budget
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_budget_to new_budget
    then_my_style_feed_should_contain top
    then_my_style_feed_should_contain bottom
    then_my_style_feed_should_contain dress
  end

  scenario 'based on hated look' do
    calibrate_shopper_and_items_except_for :hated_look

    look = FactoryGirl.create(:look, name: "Bohemian Chic")

    set_primary_look_for_items look

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_look_as look, :hate
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_feelings_for_a_look_as look, :impartial
    then_my_style_feed_should_contain top
    then_my_style_feed_should_contain bottom
    then_my_style_feed_should_contain dress
  end

  scenario 'based on parts to cover' do
    calibrate_shopper_and_items_except_for :hated_look

    midsection = FactoryGirl.create(:part, name: "Midsection")
    legs = FactoryGirl.create(:part, name: "Legs")

    set_exposed_parts_for_items upper_body: midsection, lower_body: legs

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_coverage_preference_as [midsection, legs], :cover
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_coverage_preference_as [midsection, legs], :impartial
    then_my_style_feed_should_contain top
    then_my_style_feed_should_contain bottom
    then_my_style_feed_should_contain dress
  end

  scenario 'based on colors to avoid' do
    calibrate_shopper_and_items_except_for :color_to_avoid

    color = FactoryGirl.create(:color)

    #TODO set as primary color for items
    
    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_avoided_colors color, :check
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_avoided_colors color, :uncheck
    then_my_style_feed_should_contain top
    then_my_style_feed_should_contain bottom
    then_my_style_feed_should_contain dress
  end

  def when_i_set_my_style_profile_coverage_preference_as parts, tolerance
    click_link 'Style Profile'
 
    parts.each do |part|
      within(:css, "div#part_#{part.id}") do
        if tolerance == :cover
          choose "Cover"
        end
        if tolerance == :impartial
          choose "Mix it up"
        end
        if tolerance == :love
          choose "Show off"
        end
      end
    end
 
    click_button style_profile_save 

    expect(page).to have_content('My Style Feed')
  end

  def when_i_set_my_style_profile_avoided_colors color, action
    click_link 'Style Profile'

    within(:css, "div.avoided-colors") do
      if action == :check
        check(color.name)
      elsif action == :uncheck
        uncheck(color.name)
      end
    end

    click_button style_profile_save 

    expect(page).to have_content('My Style Feed')
  end

  private
    def set_exposed_parts_for_items parts_hash
      top.exposed_parts.create(part_id: parts_hash[:upper_body].id)
      bottom.exposed_parts.create(part_id: parts_hash[:lower_body].id)
      dress.exposed_parts.create(part_id: parts_hash[:upper_body].id)
      dress.exposed_parts.create(part_id: parts_hash[:lower_body].id)
    end

    def set_sizes_for_items size_hash
      top.top_sizes << size_hash[:top_size]
      bottom.bottom_sizes << size_hash[:bottom_size]
      dress.dress_sizes << size_hash[:dress_size]
    end

    def set_prices_for_items price
      top.price = price
      bottom.price = price
      dress.price = price

      top.save
      bottom.save
      dress.save
    end

    def set_primary_look_for_items look
      top.look = look
      bottom.look = look
      dress.look = look

      top.save
      bottom.save
      dress.save
    end

    def calibrate_shopper_and_items_except_for tested_property
      calibrate_shopper_and_top_except_for tested_property
      calibrate_shopper_and_bottom_except_for tested_property
      calibrate_shopper_and_dress_except_for tested_property

      unless tested_property == :hated_look
        shopper.style_profile.look_tolerances.delete_all
      end
      unless tested_property == :part_coverage
        shopper.style_profile.part_exposure_tolerances.delete_all
      end
      unless tested_property == :color_to_avoid
        shopper.style_profile.hated_colors.delete_all
      end
    end

    def calibrate_shopper_and_top_except_for tested_property
      unless tested_property == :size
        shared_size = FactoryGirl.create(:top_size)
        shopper.style_profile.top_sizes << shared_size
        top.top_sizes << shared_size
      end
      unless tested_property == :budget
        shopper.style_profile.budget.top_min_price = 50.00
        shopper.style_profile.budget.top_max_price = 100.00
        shopper.style_profile.budget.save
        top.price = 75.00
        top.save
      end
    end

    def calibrate_shopper_and_bottom_except_for tested_property
      unless tested_property == :size
        shared_size = FactoryGirl.create(:bottom_size)
        shopper.style_profile.bottom_sizes << shared_size
        bottom.bottom_sizes << shared_size
      end
      unless tested_property == :budget
        shopper.style_profile.budget.bottom_min_price = 50.00
        shopper.style_profile.budget.bottom_max_price = 100.00
        shopper.style_profile.budget.save
        bottom.price = 75.00
        bottom.save
      end
    end

    def calibrate_shopper_and_dress_except_for tested_property
      unless tested_property == :size
        shared_size = FactoryGirl.create(:dress_size)
        shopper.style_profile.dress_sizes << shared_size
        dress.dress_sizes << shared_size
      end
      unless tested_property == :budget
        shopper.style_profile.budget.dress_min_price = 50.00
        shopper.style_profile.budget.dress_max_price = 100.00
        shopper.style_profile.budget.save
        dress.price = 75.00
        dress.save
      end
    end
end
