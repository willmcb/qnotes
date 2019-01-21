class Collection < ApplicationRecord
  belongs_to :user
  has_many :notes
  validates :name, presence: true, uniqueness: true
  validates_length_of :name, maximum: 100, allow_blank: false
end
