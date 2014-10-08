require 'rails_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before {visit '/'}

    it { should have_content('Explore Fashion Boutiques') }
    it { should have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile') }
  end

  describe "About page" do
    before {visit '/about'}

    it { should have_content('About us') }
    it { should have_title('About | OpenStile') }
  end

  describe "Prelaunch page" do
    before {visit '/prelaunch'}

    it { should have_content('Sign up for when we launch') }
    it { should have_title('Explore Washington DC Fashion Boutiques | OpenStile') }
  end
end
