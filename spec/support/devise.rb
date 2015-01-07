# Workaround for specs for routes defined with authenticated
# specified in https://github.com/plataformatec/devise/issues/1670

module Devise::RoutingTestHelpers
  attr_accessor :request

  def initialize(*args)
    request
    super(*args)
  end

  def request
    @request ||= Hashie::Mash.new env: {}
  end

  def setup_controller(controller=subject)
    request.env['action_controller.instance'] = @controller = controller
  end

  def sign_in!
    NilClass.any_instance.unstub(:authenticate?)
    NilClass.any_instance.stubs(:authenticate?).returns(true)
  end

  def sign_out!
    NilClass.any_instance.stubs(:authenticate?).returns(false)
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::RoutingTestHelpers, type: :routing
  config.include Devise::TestHelpers, type: :routing

  config.before(:each, type: :routing) do
    setup_controller
    sign_out!
  end
end
