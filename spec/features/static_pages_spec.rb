require 'rails_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have content 'Explore Fashion Boutiques'" do
      visit '/'
      expect(page).to have_content('Explore Fashion Boutiques')
    end
  end

  describe "Our story page" do
    it "should have content 'Our story'" do
      visit '/our_story'
      expect(page).to have_content('Our story')
    end
  end

  describe "Prelaunch page" do
    it "should have content 'Sign up for when we launch'" do
      visit '/prelaunch'
      expect(page).to have_content('Sign up for when we launch')
    end
  end
end
