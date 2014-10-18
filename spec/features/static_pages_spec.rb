require 'rails_helper'

describe "Static pages" do
  subject { page }

  shared_examples "static_page" do
    it { should have_link("Home", href: root_path) }
    it { should have_link("About", href: about_path) }
    #TODO add href for blog page
    it { should have_link("Blog") }

    it { should have_xpath("//footer") }
  end

  describe "Home page" do
    before {visit '/'}

    it_should_behave_like "static_page"
    it { should have_content('Explore Fashion Boutiques') }
    it { should have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile') }
  end

  describe "About page" do
    before {visit '/about'}

    it_should_behave_like "static_page"
    it { should have_content('About us') }
    it { should have_title('About | OpenStile') }
  end
end