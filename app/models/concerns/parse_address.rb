module ParseAddress
  extend ActiveSupport::Concern

  def self.get_address obj
    if obj.respond_to?("location")
      address = StreetAddress::US.parse(obj.location.address)
    elsif obj.respond_to?("retailer")
      address = StreetAddress::US.parse(obj.retailer.location.address)
    end
  end

  # 1600
  def self.get_number obj
    ParseAddress.number obj
  end

  # Pennsylvania
  def self.get_street obj
    ParseAddress.get_street obj
  end

  # Ave
  def self.get_type obj
    ParseAddress.get_type obj
  end

  # District of columbia
  def self.get_state_name obj
    ParseAddress.get_state_name obj
  end

  # DC
  def self.get_state obj
    ParseAddress.get_state obj
  end

  # Washington
  def self.get_city obj
    ParseAddress.get_city obj
  end

  # 20500
  def self.postal_code obj
    ParseAddress.postal_code obj
  end

end