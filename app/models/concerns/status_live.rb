module StatusLive
  extend ActiveSupport::Concern

  def live?
    if self.respond_to? :retailer
      if self.retailer.status == 1 && self.status == 1
        return true
      end
    else
      return true if self.status == 1
    end
  end
end
