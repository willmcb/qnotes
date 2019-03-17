class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :notes, through: :taggings
  belongs_to :user
  validates_presence_of :name, presence: true, uniqueness: true
end
