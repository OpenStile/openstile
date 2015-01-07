require 'rails_helper'

describe "Blog" do
  subject { page }

  shared_examples "site_page" do
    it { should have_link("OpenStile", href: root_path) }
    it { should have_link("About", href: about_path) }
    it { should have_link("Blog", href: blog_path) }
    it { should have_link("Log in") }

    it { should have_xpath("//footer") }
    it { should have_xpath("//a[contains(@href, 'https://twitter.com/OpenStile')]") }
    it { should have_xpath("//a[contains(@href, 'https://www.facebook.com/openstile')]") }
    it { should have_xpath("//a[contains(@href, 'http://instagram.com/openstile')]") }
  end

  describe "Index" do
    before {visit '/blog'}

    it_should_behave_like "site_page"
    it { should have_content('Blog') }
    it { should have_title('Blog | OpenStile') }

    it { should have_xpath("//a[contains(@href, #{blog_welcome_to_openstile_path})]") }
    it { should have_xpath("//a[contains(@href, #{blog_retailer_spotlight_tin_lizzy_path})]") }
    it { should have_xpath("//a[contains(@href, #{blog_dressing_mommy_post_baby_phase_path})]") }
  end

  describe "Welcome to OpenStile" do
    before {visit '/blog/welcome-to-openstile'}

    it_should_behave_like "site_page"
    it { should have_title('Welcome to OpenStile | OpenStile') }
  end

  describe "Retailer Spotlight Tin Lizzy" do
    before {visit '/blog/retailer-spotlight-tin-lizzy'}

    it_should_behave_like "site_page"
    it { should have_title('Retailer Spotlight Tin Lizzy | OpenStile') }
  end

  describe "Dressing Mommy Post Baby Phase" do
    before {visit '/blog/dressing-mommy-post-baby-phase'}

    it_should_behave_like "site_page"
    it { should have_title('Dressing Mommy Post Baby Phase | OpenStile') }
  end
end

