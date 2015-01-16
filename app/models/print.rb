class Print < ActiveRecord::Base
  has_many :print_tolerances, dependent: :destroy
end
