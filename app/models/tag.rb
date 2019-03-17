class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :notes, through: :taggings
  belongs_to :user
  validates_presence_of :name
  validates :name, uniqueness: { message: "Tag already exists" }
end
