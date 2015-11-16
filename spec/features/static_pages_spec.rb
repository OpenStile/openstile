require 'rails_helper'

describe "Static pages" do
  subject { page }

  shared_examples "static_page" do
    it { should have_link("logo-home", href: root_path) }
    it { should have_link("About", href: about_path) }
    it { should have_link("Blog", href: blog_articles_path) }
    it { should have_link("Log in") }

    it { should have_xpath("//footer") }
    it { should have_xpath("//a[contains(@href, 'https://twitter.com/openstile')]") }
    it { should have_xpath("//a[contains(@href, 'https://facebook.com/openstile')]") }
    it { should have_xpath("//a[contains(@href, 'https://instagram.com/openstile')]") }
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
end
