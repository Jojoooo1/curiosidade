class Article < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :childs, class_name: "Article", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Article", optional: true

  has_many :types, dependent: :destroy
  has_many :categories, through: :types
  validates_uniqueness_of :slug
  validates :slug, presence: true

  paginates_per 2

  def to_param
    slug
  end
  def name
    title
  end
end
