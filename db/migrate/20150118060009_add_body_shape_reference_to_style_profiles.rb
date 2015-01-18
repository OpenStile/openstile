class AddBodyShapeReferenceToStyleProfiles < ActiveRecord::Migration
  def change
    add_reference :style_profiles, :body_shape, index: true
  end
end
