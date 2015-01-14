require 'rails_helper'

feature 'Style Feed retailer matching' do
  let(:retailer){ FactoryGirl.create(:retailer) }  
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }  

  scenario 'based on size' do
    calibrate_shopper_and_top_except_for :size
    calibrate_shopper_and_bottom_except_for :size
    calibrate_shopper_and_dress_except_for :size

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

  private
    def set_sizes_for_items size_hash
      top.top_sizes << size_hash[:top_size]
      bottom.bottom_sizes << size_hash[:bottom_size]
      dress.dress_sizes << size_hash[:dress_size]
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
        bottom.dress_sizes << shared_size
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
