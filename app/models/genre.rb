class Genre < ApplicationRecord
  has_many :post_images

  validates :name, presence: true, uniqueness: true
end
