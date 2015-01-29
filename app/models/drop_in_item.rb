class DropInItem < ActiveRecord::Base
  belongs_to :drop_in
  belongs_to :reservable, polymorphic: true

  validate :retailer_for_drop_in_and_item_match
  validates :drop_in_id, presence: true, on: :update
  validates :reservable_id, presence: true

  def retailer_for_drop_in_and_item_match
    unless reservable_id.nil? or drop_in_id.nil?
      if reservable.retailer_id != drop_in.retailer_id
        errors.add(:reservable, "must belong to the same retailer as the drop in")
      end
    end
  end
end
