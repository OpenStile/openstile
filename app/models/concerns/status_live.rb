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

  def self.included(base)
    base.extend(ClassMethods)  
  end

  module ClassMethods
    def all_live
      ret = none

      if self == Retailer
        ret = where(status: 1)
      else
        live_retailer_ids = Retailer.all_live.pluck :id
        ret = where(status: 1, retailer_id: live_retailer_ids)
      end

      ret
    end
  end  
end
