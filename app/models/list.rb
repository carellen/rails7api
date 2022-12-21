class List < ApplicationRecord
  belongs_to :user
  has_many :list_items, dependent: :destroy

  acts_as_paranoid

  scope :shared, -> { where(shared: true) }
end
