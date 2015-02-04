require 'rails_helper'

RSpec.describe StyleProfile, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }

  before do
    @style_profile = shopper.style_profile
  end
  subject { @style_profile }

  it { should respond_to :shopper_id }
  it { should respond_to :shopper }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should respond_to :budget }
  it { should respond_to :look_tolerances }
  it { should respond_to :part_exposure_tolerances }
  it { should respond_to :hated_colors }
  it { should respond_to :avoided_colors }
  it { should respond_to :avoided_color_ids }
  it { should respond_to :print_tolerances }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :height_feet }
  it { should respond_to :height_inches }
  it { should respond_to :body_build }
  it { should respond_to :top_fit }
  it { should respond_to :bottom_fit }
  it { should respond_to :special_considerations }
  it { should be_valid }

  context "when shopper id is not present" do
    before { @style_profile.shopper_id = nil }
    it { should_not be_valid }
  end

  describe "budget association" do
    it "should create associated budget after create" do
      expect(@style_profile.budget).to_not be_nil
    end

    it "should destroy associated budget" do
      style_profile_budget = @style_profile.budget
      @style_profile.destroy
      expect(style_profile_budget).to_not be_nil
      expect(Budget.where(id: style_profile_budget.id)).to be_empty
    end
  end

  describe "look tolerance association" do
    let(:look){ FactoryGirl.create(:look) }
    let!(:look_tolerance){ FactoryGirl.create(:look_tolerance, 
                               style_profile: @style_profile, 
                               look: look) }

    it "should destroy associated look tolerance" do
      look_tolerances = @style_profile.look_tolerances.to_a
      @style_profile.destroy
      expect(look_tolerances).to_not be_empty
      look_tolerances.each do |lt|
        expect(LookTolerance.where(id: lt.id)).to be_empty
      end
    end
  end

  describe "part exposure association" do
    let(:part){ FactoryGirl.create(:part) }
    let!(:part_exposure_tolerance){ FactoryGirl.create(:part_exposure_tolerance, 
                                                        style_profile: @style_profile, 
                                                        part: part) }

    it "should destroy associated part exposure tolerance" do
      part_exposure_tolerances = @style_profile.part_exposure_tolerances.to_a
      @style_profile.destroy
      expect(part_exposure_tolerances).to_not be_empty
      part_exposure_tolerances.each do |pt|
        expect(PartExposureTolerance.where(id: pt.id)).to be_empty
      end
    end
  end

  describe "hated colors association" do
    let(:color){ FactoryGirl.create(:color) }
    let!(:hated_color){ FactoryGirl.create(:hated_color,
                                           style_profile: @style_profile,
                                           color: color) }

    it "should populate avoided colors for shopper" do
      expect(@style_profile.avoided_colors).to include(color)
      expect(@style_profile.avoided_color_ids).to include(color.id)
    end

    it "should destroy associated hated color" do
      hated_colors = @style_profile.hated_colors.to_a
      @style_profile.destroy
      expect(hated_colors).to_not be_empty
      hated_colors.each do |hc|
        expect(HatedColor.where(id: hc.id)).to be_empty
      end
    end
  end

  describe "print tolerance association" do
    let(:print){ FactoryGirl.create(:print) }
    let!(:print_tolerance){ FactoryGirl.create(:print_tolerance, 
                               style_profile: @style_profile, 
                               print: print) }

    it "should destroy associated print tolerance" do
      print_tolerances = @style_profile.print_tolerances.to_a
      @style_profile.destroy
      expect(print_tolerances).to_not be_empty
      print_tolerances.each do |lt|
        expect(PrintTolerance.where(id: lt.id)).to be_empty
      end
    end
  end

  describe "synopsis" do
    before { shopper.first_name = 'Jane' }

    context "when height, build, and body shape are present" do
      before do 
        @style_profile.height_feet = 5
        @style_profile.height_inches = 2
        @style_profile.body_build = 'Athletic'
        @style_profile.body_shape = 
                FactoryGirl.create(:body_shape, name: 'Hourglass')
      end

      it "should capture the fields in a readable sentence" do
        expect(@style_profile.synopsis)
          .to include("Jane is petite with athletic build and hourglass shape.")
      end
    end

    context "when sizes are present" do
      before do
        @style_profile.top_sizes << FactoryGirl.create(:top_size, name: 'XS',
                                                                  category: 'alpha')
        @style_profile.top_sizes << FactoryGirl.create(:top_size, name: 'S',
                                                                  category: 'alpha')
        @style_profile.top_sizes << FactoryGirl.create(:top_size, name: '0',
                                                                  category: 'numeric')
        @style_profile.top_sizes << FactoryGirl.create(:top_size, name: '2',
                                                                  category: 'numeric')
        
        @style_profile.bottom_sizes << FactoryGirl.create(:bottom_size, name: 'Medium',
                                                                        category: 'alpha')
        @style_profile.bottom_sizes << FactoryGirl.create(:bottom_size, name: '6',
                                                                        category: 'numeric')
        @style_profile.bottom_sizes << FactoryGirl.create(:bottom_size, name: '27',
                                                                        category: 'inches')
        @style_profile.bottom_sizes << FactoryGirl.create(:bottom_size, name: '28',
                                                                        category: 'inches')

        @style_profile.dress_sizes << FactoryGirl.create(:dress_size, name: 'Medium')
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She wears top size 0-2 (XS or S).")
        expect(@style_profile.synopsis)
          .to include("She wears bottom size 6 and waist 27-28 (Medium).")
        expect(@style_profile.synopsis)
          .to include("She wears dress size Medium.")
      end
    end

    context "when budget is present" do
      before do 
        @style_profile.budget.top_min_price = 0
        @style_profile.budget.top_max_price = 50
        @style_profile.budget.bottom_min_price = 100
        @style_profile.budget.bottom_max_price = 150
        @style_profile.budget.dress_min_price = 200
        @style_profile.budget.dress_max_price = Budget::ABSOLUTE_MAX
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She spends < $50 on tops (shirts, blouses, sweaters)," +
                      " $100 - $150 on bottoms (slacks, skirts, jeans)," +
                      " $200 + on dresses (everyday, work, transitional)")
      end
    end

    context "when special considerations are present" do
      let(:eco_friendly){ FactoryGirl.create(:special_consideration,
                                             name: 'Eco-friendly')}
      let(:second_wear){ FactoryGirl.create(:special_consideration,
                                            name: 'Second-wear')}
      before do
        @style_profile.special_considerations << eco_friendly
        @style_profile.special_considerations << second_wear
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She values eco-friendly and second-wear fashion.")
      end
    end

    context "when hated and loved looks are present" do
      let(:boho_chic){ FactoryGirl.create(:look, name: 'Bohemian_Chic') }
      let(:edgy_rocker){ FactoryGirl.create(:look, name: 'Edgy_Rocker') }
      let(:glam_diva){ FactoryGirl.create(:look, name: 'Glam_Diva') }
      before do
        @style_profile.look_tolerances << FactoryGirl.create(:look_tolerance, 
                                                             style_profile: @style_profile,
                                                             look: boho_chic, tolerance: 1)
        @style_profile.look_tolerances << FactoryGirl.create(:look_tolerance, 
                                                             style_profile: @style_profile,
                                                             look: edgy_rocker, tolerance: 1)
        @style_profile.look_tolerances << FactoryGirl.create(:look_tolerance, 
                                                             style_profile: @style_profile,
                                                             look: glam_diva, tolerance: 10)
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She loves the glam-diva look" + 
                      ", but hates the bohemian-chic and edgy-rocker looks.")
      end
    end

    context "when top and bottom fit are present" do
      before do
        @style_profile.top_fit = 'Tight/Form-Fitting'
        @style_profile.bottom_fit = 'Loose/Flowy'
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She prefers her tops to be Tight/Form-Fitting" +
                      " and her bottoms to be Loose/Flowy")
      end
    end

    context "when parts to cover and flaunt are present" do
      let(:back){ FactoryGirl.create(:part, name: 'Back') }
      let(:midsection){ FactoryGirl.create(:part, name: 'Midsection') }
      let(:arms){ FactoryGirl.create(:part, name: 'Arms') }
      before do
        @style_profile.part_exposure_tolerances << FactoryGirl.create(:part_exposure_tolerance,
                                                                      part: back,
                                                                      style_profile: @style_profile,
                                                                      tolerance: 1)
        @style_profile.part_exposure_tolerances << FactoryGirl.create(:part_exposure_tolerance,
                                                                      part: midsection,
                                                                      style_profile: @style_profile,
                                                                      tolerance: 1)
        @style_profile.part_exposure_tolerances << FactoryGirl.create(:part_exposure_tolerance,
                                                                      part: arms,
                                                                      style_profile: @style_profile,
                                                                      tolerance: 10)
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She prefers to cover her back and midsection, and to flaunt her arms.")
      end
    end

    context "when hated and loved prints are present" do
      let(:animal_prints){ FactoryGirl.create(:print, name: 'Animal Prints') }
      let(:bright_colors){ FactoryGirl.create(:print, name: 'Bright Colors') }
      let(:fur){ FactoryGirl.create(:print, name: 'Fur') }
      before do
        @style_profile.print_tolerances << FactoryGirl.create(:print_tolerance,
                                                              print: animal_prints,
                                                              style_profile: @style_profile,
                                                              tolerance: 1)
        @style_profile.print_tolerances << FactoryGirl.create(:print_tolerance,
                                                              print: bright_colors,
                                                              style_profile: @style_profile,
                                                              tolerance: 10)
        @style_profile.print_tolerances << FactoryGirl.create(:print_tolerance,
                                                              print: fur,
                                                              style_profile: @style_profile,
                                                              tolerance: 10)
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("She loves bright colors and fur, but hates animal prints.")
      end
    end

    context "when avoided colors are present" do
      let(:brown){ FactoryGirl.create(:color, name: 'Brown') }
      let(:orange){ FactoryGirl.create(:color, name: 'Orange') }
      before do
        @style_profile.hated_colors << FactoryGirl.create(:hated_color,
                                                          color: brown,
                                                          style_profile: @style_profile)
        @style_profile.hated_colors << FactoryGirl.create(:hated_color,
                                                          color: orange,
                                                          style_profile: @style_profile)
      end

      it "should capture the fields in readable sentences" do
        expect(@style_profile.synopsis)
          .to include("Lastly, she avoids the colors brown and orange.")
      end
    end
  end
end
