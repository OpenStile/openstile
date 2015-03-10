module CommonValidations
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations

    VALID_PHONE_REGEX = /\A\d{10,11}\z/

    before_validation(on: :create) do
      if self.respond_to?("phone")
        # puts "This happened!"
        # puts "Self.inspect: " + self.inspect
        phone.gsub!(/[^0-9]/, "") if attribute_present?("phone")
      elsif self.respond_to?("cell_phone")
        cell_phone.gsub!(/[^0-9]/, "") if attribute_present?("cell_phone")
      end
    end

    validates :phone, presence: true, format: { with: VALID_PHONE_REGEX, message: "must be 10 or 11 numeric digits." }
  end
end
