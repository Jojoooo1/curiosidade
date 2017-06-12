class Article < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :types, :dependent => :destroy
  has_many :categories, :through => :types
  validates_uniqueness_of :slug
  validates :slug, presence: true

  paginates_per 2

  def to_param
    slug
  end

end
