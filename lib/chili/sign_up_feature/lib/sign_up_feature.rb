require "chili"
require "sign_up_feature/engine"

module SignUpFeature
  extend Chili::Base
  active_if { !Rails.env.production? } # edit this to activate/deactivate feature at runtime
end
