module ParseAddress
  extend ActiveSupport::Concern

  def self.get_address obj
    if obj.respond_to?("location")
      address = StreetAddress::US.parse(obj.location.address)
    elsif obj.respond_to?("retailer")
      address = StreetAddress::US.parse(obj.retailer.location.address)
    end
  end
end