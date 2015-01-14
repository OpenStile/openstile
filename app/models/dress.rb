class Dress < ActiveRecord::Base
  has_and_belongs_to_many :dress_sizes

  validates :name, presence: true, length: { maximum: 100 } 
  validates :description, presence: true, length: { maximum: 250 }
  validates :web_link, length: { maximum: 100 }
  validates :price, presence: true

end
