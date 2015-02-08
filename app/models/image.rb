class Image < ActiveRecord::Base

  belongs_to :retailer
  belongs_to :top
  belongs_to :bottom
  belongs_to :dress

  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :format, presence: true, :inclusion => { :in => %w(jpg) }

end
