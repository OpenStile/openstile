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

    set_primary_color_for_items color
    
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

  scenario 'based on hated print' do
    calibrate_shopper_and_items_except_for :hated_print

    print = FactoryGirl.create(:print, name: "Animal Print")

    set_primary_print_for_items print

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_print_as print, :hate
    then_my_style_feed_should_not_contain top
    then_my_style_feed_should_not_contain bottom
    then_my_style_feed_should_not_contain dress
    when_i_set_my_style_profile_feelings_for_a_print_as print, :impartial
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

  def when_i_set_my_style_profile_feelings_for_a_print_as print, partiality
    click_link 'Style Profile'

    within(:css, "div#print_#{print.id}") do
      if partiality == :hate
        choose "Hate"
      end
      if partiality == :impartial
        choose "Impartial"
      end
      if partiality == :love
        choose "Love"
      end
    end
 
    click_button style_profile_save 

    expect(page).to have_content('My Style Feed')
  end


  private
    def set_primary_print_for_items print
      top.update!(print_id: print.id)
      bottom.update!(print_id: print.id)
      dress.update!(print_id: print.id)
    end

    def set_primary_color_for_items color
      top.color = color
      bottom.color = color
      dress.color = color

      top.save
      bottom.save
      dress.save
    end

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
        bad_look = FactoryGirl.create(:look, name: "Look I don't like")
        indifferent_look = FactoryGirl.create(:look, name: "Look I can take or leave")
        shopper.style_profile.look_tolerances.create(look_id: indifferent_look.id, 
                                                     tolerance: 5)
        shopper.style_profile.look_tolerances.create(look_id: bad_look.id, 
                                                     tolerance: 1)

        # Ensure that items with non-hated looks or no look aren't filtered out                                                      
        top.update!(look_id: indifferent_look.id)                                                     
        bottom.update!(look_id: nil)                                                      
        dress.update!(look_id: nil)                                                     
      end

      unless tested_property == :part_coverage
        part_to_cover = FactoryGirl.create(:part, name: "Part to cover")
        part_i_show = FactoryGirl.create(:part, name: "Part I show")
        shopper.style_profile.part_exposure_tolerances.create(part_id: part_to_cover.id,
                                                              tolerance: 1)
        shopper.style_profile.part_exposure_tolerances.create(part_id: part_i_show.id,
                                                              tolerance: 5)

        # Ensure that items exposing parts I don't mind showing or 
        # that expose nothing aren't filtered out                                                      
        top.exposed_parts.create(part_id: part_i_show.id)
        bottom.exposed_parts.delete_all
        dress.exposed_parts.delete_all
      end

      unless tested_property == :color_to_avoid
        hated_color = FactoryGirl.create(:color, name: "Color I don't like")
        indifferent_color = FactoryGirl.create(:color, name: "Color I don't hate")
        shopper.style_profile.avoided_colors << hated_color

        # Ensure that items with non-hated color or no primary color aren't filtered out                                                      
        top.update!(color_id: indifferent_color.id)
        bottom.update!(color_id: nil)
        dress.update!(color_id: nil)
      end

      unless tested_property == :hated_print
        bad_print = FactoryGirl.create(:print, name: "Print I don't like")
        indifferent_print = FactoryGirl.create(:print, name: "Print I can take or leave")
        shopper.style_profile.print_tolerances.create(print_id: indifferent_print.id, 
                                                     tolerance: 5)
        shopper.style_profile.print_tolerances.create(print_id: bad_print.id, 
                                                     tolerance: 1)

        # Ensure that items with non-hated prints or no print aren't filtered out                                                      
        top.update!(print_id: indifferent_print.id)                                                     
        bottom.update!(print_id: nil)                                                      
        dress.update!(print_id: nil)                                                     
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
