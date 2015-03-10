module Callable
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations

    VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

    before_validation(on: :create) do
      phone_number.gsub!(/[^0-9]/, "") if attribute_present?("phone_number")
    end

    validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: "must be 10 or 11 numeric digits." }
  end
end
