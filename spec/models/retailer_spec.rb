require 'rails_helper'

RSpec.describe Retailer, :type => :model do
  let(:location){ FactoryGirl.create(:location,
                                      neighborhood: "Shaw") }
  before { @retailer = Retailer.new(name: "ABC Boutique",
                                    description: "Premier boutique in DC!",
                                    location: location,
                                    owner_name: 'Seymour Butts',
                                    phone_number: '571-555-5555') }

  subject { @retailer }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should respond_to :price_range }
  it { should respond_to :look }
  it { should respond_to :look_id }
  it { should respond_to :primary_look }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :for_petite }
  it { should respond_to :for_tall }
  it { should respond_to :for_full_figured }
  it { should respond_to :top_fit }
  it { should respond_to :top_fit_id }
  it { should respond_to :bottom_fit }
  it { should respond_to :bottom_fit_id }
  it { should respond_to :special_considerations }
  it { should respond_to :online_presence }
  it { should respond_to :drop_in_availabilities }
  it { should respond_to :drop_ins }
  it { should respond_to :location }
  it { should respond_to :location_id }
  it { should respond_to :retail_user }
  it { should respond_to :image_name }
  it { should respond_to :logo_image_name }
  it { should respond_to :outfits }
  it { should respond_to :status }
  it { should respond_to :live? }
  it { should respond_to :summary }
  it { should respond_to :owner_name }
  it { should respond_to :phone_number }
  it { should be_valid }

  context "when name is not present" do
    before { @retailer.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @retailer.name = "a"*51 }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @retailer.description = " " }
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @retailer.description = "a"*251 }
    it { should_not be_valid }
  end

  context "when location id is not present" do
    before { @retailer.location_id = nil }
    it { should_not be_valid }
  end

  describe "price range association" do
    before { @retailer.save }
    let!(:price_range){ FactoryGirl.create(:price_range, retailer: @retailer) }

    it "should destroy associated price range" do
      retailer_price_range = @retailer.price_range
      @retailer.destroy
      expect(retailer_price_range).to_not be_nil
      expect(PriceRange.where(id: retailer_price_range.id)).to be_empty
    end
  end

  describe "tops assocication" do
    before { @retailer.save }
    let!(:top) { FactoryGirl.create(:top, retailer: @retailer) }

    it "should destroy associated tops" do
      tops = @retailer.tops.to_a
      @retailer.destroy
      expect(tops).to_not be_empty
      tops.each do |t|
        expect(Top.where(id: t.id)).to be_empty
      end
    end
  end

  describe "bottoms assocication" do
    before { @retailer.save }
    let!(:bottom) { FactoryGirl.create(:bottom, retailer: @retailer) }

    it "should destroy associated bottoms" do
      bottoms = @retailer.bottoms.to_a
      @retailer.destroy
      expect(bottoms).to_not be_empty
      bottoms.each do |b|
        expect(Bottom.where(id: b.id)).to be_empty
      end
    end
  end

  describe "dresses assocication" do
    before { @retailer.save }
    let!(:dress) { FactoryGirl.create(:dress, retailer: @retailer) }

    it "should destroy associated dresses" do
      dresses = @retailer.dresses.to_a
      @retailer.destroy
      expect(dresses).to_not be_empty
      dresses.each do |d|
        expect(Dress.where(id: d.id)).to be_empty
      end
    end
  end

  describe "online presence association" do
    before { @retailer.save }
    let!(:online_presence){
      FactoryGirl.create(:online_presence, retailer: @retailer)
    }

    it "should destroy associated online presence" do
      retailer_online_presence = @retailer.online_presence
      @retailer.destroy
      expect(retailer_online_presence).to_not be_nil
      expect(OnlinePresence.where(id: retailer_online_presence.id)).to be_empty
    end
  end

  describe "drop in avalabilities assocication" do
    before { @retailer.save }
    let!(:drop_in_availability) { FactoryGirl.create(:drop_in_availability,
                                                      retailer: @retailer) }

    it "should destroy associated drop in availabilities" do
      drop_in_availabilities = @retailer.drop_in_availabilities.to_a
      @retailer.destroy
      expect(drop_in_availabilities).to_not be_empty
      drop_in_availabilities.each do |d|
        expect(DropInAvailability.where(id: d.id)).to be_empty
      end
    end
  end

  describe "drop ins assocication" do
    before { @retailer.save }
    let(:shopper){ FactoryGirl.create(:shopper) }
    let!(:drop_in_availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                                   retailer: @retailer) }
    let!(:drop_in) { FactoryGirl.create(:drop_in,
                                        time: tomorrow_mid_morning,
                                        retailer: @retailer,
                                        shopper: shopper) }

    it "should destroy associated drop ins" do
      drop_ins = @retailer.drop_ins.to_a
      @retailer.destroy
      expect(drop_ins).to_not be_empty
      drop_ins.each do |d|
        expect(DropIn.where(id: d.id)).to be_empty
      end
    end
  end

  describe "retail user association" do
    before { @retailer.save }
    let!(:retail_user){
      FactoryGirl.create(:retail_user, retailer: @retailer)
    }

    it "should destroy associated retail user" do
      retailer_user = @retailer.retail_user
      @retailer.destroy
      expect(retail_user).to_not be_nil
      expect(RetailUser.where(id: retail_user.id)).to be_empty
    end
  end

  describe "outfits association" do
    before { @retailer.save }
    let!(:outfit){ FactoryGirl.create(:outfit, retailer: @retailer) }

    it "should destroy associated outfit" do
      retailer_outfits = @retailer.outfits.to_a
      @retailer.destroy
      expect(retailer_outfits).to_not be_empty
      retailer_outfits.each do |o|
        expect(Outfit.where(id: o.id)).to be_empty
      end
    end
  end

  describe "status" do
    context "when not set" do
      before { @retailer.status = nil }
      it { should_not be_live }
    end

    context "when it is 1" do
      before { @retailer.status = 1 }
      it { should be_live }
    end
  end

  describe "owner" do
    context "when first name is not present" do
      before { @retailer.owner_name = " " }
      it { should_not be_valid }
    end

    context "when first name is too long" do
      before { @retailer.owner_name = "a"*101 }
      it { should_not be_valid }
    end
  end

  describe "phone_number" do
    context "when phone_number is blank" do
      before { @retailer.phone_number = "" }
      it { should_not be_valid }
    end

    context "when phone_number format is invalid" do
      it "should be invalid" do
        numbers = %w[123-aaa-5555 123-4563 123-456-789012]
        numbers.each do |number|
          @retailer.phone_number = number
          expect(@retailer).not_to be_valid
        end
      end
    end

    context "when phone_number format is valid" do
      it "should be valid" do
        numbers = ['123-456-7890', '123.456.7890', '1234567890',
                   '(123) 456-7890', '1-123-456-7890']
        numbers.each do |number|
          @retailer.phone_number = number
          expect(@retailer).to be_valid
        end
      end
    end
  end

  describe "image name helper" do
    let(:location){ FactoryGirl.create(:location,
                                        address: "301 Water St. SE, Washington, DC 20003") }
    let(:retailer){ FactoryGirl.create(:retailer, name: "Elena's Boutique")}

    it "should return the correct image name" do
      expect(retailer.image_name).to eq("dc/washington/elena_s_boutique/storefront.jpg")
    end

    it "should return the correct logo image name" do
      expect(retailer.logo_image_name).to eq("dc/washington/elena_s_boutique/logo.jpg")
    end
  end

  describe "summary string helper" do
    it "should summarize the retailers neigborhood" do
      expect(@retailer.summary).to eq("Shaw")
    end
  end

  describe "avaialable drop in dates" do
    before { @retailer.save }
    context "with a one-time availability" do
      let!(:availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                               retailer: @retailer)}
      it "should return the date" do
        returned_array_dates = @retailer.get_available_drop_in_dates(:integer_array,
                                                                1.day.from_now.beginning_of_month.to_date,
                                                                1.day.from_now.end_of_month.to_date)

        returned_string_dates = @retailer.get_available_drop_in_dates(:date_string,
                                                                1.day.from_now.beginning_of_month.to_date,
                                                                1.day.from_now.end_of_month.to_date)
        expect(returned_array_dates.size).to eq(1)
        expect(returned_array_dates[0][0]).to eq(1.day.from_now.year)
        expect(returned_array_dates[0][1]).to eq(1.day.from_now.month - 1)
        expect(returned_array_dates[0][2]).to eq(1.day.from_now.day)

        expect(returned_string_dates.size).to eq(1)
        expect(returned_string_dates.first).to eq(1.day.from_now.to_date.to_s)
      end
    end

    context "with a weekly availability" do
      let!(:availability){ FactoryGirl.create(:drop_in_availability,
                                               template_date: "Sun, 01 Feb 2015",
                                               start_time: "09:00:00",
                                               end_time: "17:00:00",
                                               frequency: "Weekly",
                                               retailer: @retailer) }

      it "should return all Sundays for the month" do
        returned_dates = @retailer.get_available_drop_in_dates(:date_string,
                                                               DateTime.parse("2020-02-01").to_date,
                                                               DateTime.parse("2020-02-28").to_date)

        expect(returned_dates).to eq(["2020-02-02", "2020-02-09", "2020-02-16", "2020-02-23"])
      end
    end

    context "with a daily availability" do
      let!(:availability){ FactoryGirl.create(:drop_in_availability,
                                               template_date: DateTime.current.to_date,
                                               start_time: "09:00:00",
                                               end_time: "17:00:00",
                                               frequency: "Daily",
                                               created_at: 1.day.ago,
                                               retailer: @retailer) }

      it "should return everyday for the week" do
        returned_dates = @retailer.get_available_drop_in_dates(:date_string,
                                                               1.day.from_now.to_date,
                                                               8.days.from_now.to_date)

        expect(returned_dates.size).to eq(7)
      end

      context "with specific days turned off" do
        let!(:off_availability){ FactoryGirl.create(:drop_in_availability,
                                                    template_date: 2.days.from_now.to_date,
                                                    frequency: "One-time",
                                                    bandwidth: 0,
                                                    created_at: 1.hour.ago,
                                                    retailer: @retailer) }
        it "should not return the off day for the week" do
          returned_dates = @retailer.get_available_drop_in_dates(:date_string,
                                                               1.day.from_now.to_date,
                                                               8.days.from_now.to_date)

          expect(returned_dates).to_not include(2.days.from_now.to_date.to_s)
          expect(returned_dates.size).to eq(6)
        end
      end
    end
  end

  describe "drop in availability helpers" do
    before { @retailer.save }
    let(:shopper){ FactoryGirl.create(:shopper) }
    let!(:tomorrow_availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                                      retailer: @retailer,
                                                      bandwidth: 1) }
    let!(:drop_in) { FactoryGirl.create(:drop_in,
                                        time: tomorrow_noon,
                                        retailer: @retailer,
                                        shopper: shopper) }

    it "should return whether or not a retailer is available" do
      expect(@retailer.available_for_drop_in? tomorrow_morning).to eq(true)
      expect(@retailer.available_for_drop_in? tomorrow_noon).to eq(false)
      expect(@retailer.available_for_drop_in? tomorrow_noon.advance(hours: 1)).to eq(true)
      expect(@retailer.available_for_drop_in? tomorrow_evening).to eq(false)
    end

    it "should return the correct available times for a day" do
      expect(@retailer
              .get_available_drop_in_times(1.day.from_now.strftime('%B %e, %Y'))
              .size).to eq(15)
      expect(@retailer
              .get_available_drop_in_times(1.day.from_now.strftime('%B %e, %Y')))
              .to include([9,0])
      expect(@retailer
              .get_available_drop_in_times(1.day.from_now.strftime('%B %e, %Y')))
              .to_not include([12,0])
      expect(@retailer
              .get_available_drop_in_times(1.day.from_now.strftime('%B %e, %Y')))
              .to include([12,30])
      expect(@retailer
              .get_available_drop_in_times(1.day.from_now.strftime('%B %e, %Y')))
              .to_not include([18,0])
    end

    context "when drop in is for today" do
      let!(:today_availability){ FactoryGirl.create(:drop_in_availability,
                                         retailer: @retailer,
                                         template_date: DateTime.current.to_date,
                                         start_time: "00:00:00",
                                         end_time: "23:59:59",
                                         bandwidth: 1) }

      it "should return an appropriate buffer" do
        first_available_time_array =
            @retailer.get_available_drop_in_times(DateTime.current.strftime('%B %e, %Y')).first

        if DateTime.current.advance(hours: 1) > DateTime.current.end_of_day
          expect(first_available_time_array).to be_nil
        else
          first_available_time = DateTime.current.change(hour: first_available_time_array[0],
                                                         min: first_available_time_array[1])

          buffered_time = DateTime.current.advance(minutes: 30)

          expect(first_available_time).to be >= buffered_time
        end
      end
    end
  end
end
