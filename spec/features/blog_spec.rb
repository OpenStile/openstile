require 'rails_helper'

describe "Blog" do
  subject { page }

  shared_examples "site_page" do
    it { should have_link("Home", href: root_path) }
    it { should have_link("About", href: about_path) }
    it { should have_link("Blog", href: blog_path) }

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
  end

  describe "Welcome to OpenStile" do
    before {visit '/blog/welcome-to-openstile'}

    it_should_behave_like "site_page"
    it { should have_title('Welcome to OpenStile | OpenStile') }
  end
end

