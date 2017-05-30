class Category < ApplicationRecord
  has_many :types, :dependent => :destroy
  has_many :articles, :through => :types
end
