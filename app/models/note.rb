class Note < ApplicationRecord
  belongs_to :user
  belongs_to :collection

  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true
  validates_length_of :title, maximum: 300, allow_blank: false

  validates :body, presence: true

  before_save do
    # add newline before code blocks
    self.body.gsub!(/```/, "\n```")
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).notes
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
