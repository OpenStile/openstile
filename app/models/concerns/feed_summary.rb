module FeedSummary
  extend ActiveSupport::Concern

  def summary
    if self.is_a? Retailer
      location.neighborhood
    else
      self.name
    end
  end
end

