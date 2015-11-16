class RetailerInterestsController < ApplicationController

 def new
    @retailer_interest = RetailerInterest.new
  end

    def create
    @retailer_interest = RetailerInterest.new
    if @retailer_interest.save
      flash[:success] = "Your Application Has Been Sent"
      redirect_to root_path
    else
      render 'new'
    end
  end
end