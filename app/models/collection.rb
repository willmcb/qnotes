class Collection < ApplicationRecord
  belongs_to :user
  has_many :notes
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates_length_of :name, maximum: 100, allow_blank: false
end
