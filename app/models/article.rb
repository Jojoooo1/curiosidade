class Article < ApplicationRecord
  has_many :types, :dependent => :destroy
  has_many :categories, :through => :types
  validates_uniqueness_of :slug
  validates :slug, presence: true

  def to_param
    slug
  end

end
