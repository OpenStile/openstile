require "chili"
require "sign_up_feature/engine"

module SignUpFeature
  extend Chili::Base
  active_if { !Rails.env.production? || Shopper.count < 50 } # edit this to activate/deactivate feature at runtime
end
