class Collection < ApplicationRecord
  belongs_to :user
  has_many :notes
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates_length_of :name, maximum: 100, allow_blank: false

  def self.all_by_name
    order(:name)
  end

  def has_notes?
    self.notes.size != 0
  end
end
