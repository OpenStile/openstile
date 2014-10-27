require 'rails_helper'

describe "Static pages" do
  subject { page }

  shared_examples "static_page" do
    it { should have_link("Home", href: root_path) }
    it { should have_link("About", href: about_path) }
    it { should have_link("Blog", href: blog_path) }

    it { should have_xpath("//footer") }
    it { should have_xpath("//a[contains(@href, 'https://twitter.com/OpenStile')]") }
    it { should have_xpath("//a[contains(@href, 'https://www.facebook.com/openstile')]") }
    it { should have_xpath("//a[contains(@href, 'http://instagram.com/openstile')]") }
  end

  describe "Home page" do
    before {visit '/'}

    it_should_behave_like "static_page"
    it { should have_content('Explore Local Fashion Retailers') }
    it { should have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile') }
  end

  describe "About page" do
    before {visit '/about'}

    it_should_behave_like "static_page"
    it { should have_content('Our Story') }
    it { should have_title('About | OpenStile') }
  end

  describe "Retailer page" do
    before {visit '/retailer_info'}

    it_should_behave_like "static_page"
    it { should have_content('Homegrown Fashion Retailers') }
    it { should have_title('Fashion Retailers Reach More Shoppers | OpenStile') }
  end

  describe "Blog page" do
    before {visit '/blog'}

    it_should_behave_like "static_page"
    it { should have_content('OpenStile Blog') }
    it { should have_title('Blog | OpenStile') }
  end
end
