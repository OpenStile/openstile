require 'rails_helper'

# describe "Login" do
  
#   before(:each) do
#     @shopper = FactoryGirl.create(:shopper)
#     login_as(@shopper, :scope => :shopper, :run_callbacks => false)
#   end

#   context "When a shopper logs in" do
#     describe "it should show the correct content" do
#       before {visit '/'}
#       it { should have_content("StyleProfiles#edit") }
#     end
#   end
# end

describe "Login" do
  subject { page }

  # before(:each) do
  #   shopper = Shopper.create(:first_name => 'Paul',
  #                      :email    => 'alindeman@example.com',
  #                      :password => 'ilovegrapes',
  #                      :password_confirmation => 'ilovegrapes')
  # end

  # describe "allows shoppers to login after they have registered" do

  #   visit "/shoppers/sign_in"

  #   fill_in "Email",    :with => "alindeman@example.com"
  #   fill_in "Password", :with => "ilovegrapes"

  #   click_button "Log in"

  #   it { should have_content('Signed in successfully.') }
  # end

  describe "with valid information" do
    before(:each) do
      shopper = Shopper.create(:first_name => 'Paul',
                         :email    => 'alindeman@example.com',
                         :password => 'ilovegrapes',
                         :password_confirmation => 'ilovegrapes')
      visit new_shopper_session_path
    end

    before do
      fill_in "Email", with: "jane@example.com"
      fill_in "Password", with: "foobarbaz"
    end

    let(:submit) { "Log in" }

    it { should have_title('Style Profile | OpenStile') }
    it { should have_content("Signed in successfully") }

  end
end
