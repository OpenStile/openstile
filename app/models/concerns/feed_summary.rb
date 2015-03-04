module FeedSummary
  extend ActiveSupport::Concern

  def summary
    if self.is_a? Retailer
      "Located in the #{location.neighborhood} neighborhood"
    elsif self.is_a? Outfit
      self.name
    else
      price_string = ("$%6.2f" % self.price.to_f).gsub(/\s+/, "")
      "#{self.name} - #{price_string}"
    end
  end
end

