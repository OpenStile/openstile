module ShoppersHelper

  def never_had_drop_in? shopper
    shopper.drop_ins.empty?
  end
end
